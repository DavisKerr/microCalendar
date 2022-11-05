import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:micro_calendar/Middleware/db_middleware.dart';

import '../../Styles/app_themes.dart' as appStyle;

import '../Model/goal.dart';
import '../Model/goal_progress.dart';
import '../Actions/goal_actions.dart';

import 'package:redux/redux.dart';

import '../State/app_state.dart';
import '../View/view_model.dart';
import 'confirmation_window.dart';

class TrackGoalPopup extends StatefulWidget {
  final Goal goal;
  final bool includeDelete;
  final DateTime startDate;
  final double startUnits;
  final int progressId;

  const TrackGoalPopup({
    required this.goal, 
    required this.startDate, 
    required this.startUnits, 
    required this.includeDelete,
    this.progressId = -1,
  });

  @override
  State<TrackGoalPopup> createState() => _TrackGoalPopupState();
}

class _TrackGoalPopupState extends State<TrackGoalPopup> {
  final TextEditingController amountController = TextEditingController();

  DateTime? _selectedDate;
  bool error = false;

  bool _checkError() {
    String amount = amountController.text;
    final pattern = RegExp(r'^[0-9]+$');
    if(pattern.hasMatch(amount) && amount.length < 30) {
      setState(() {
        error = false;
      });
    }
    else {
      setState(() {
        error = true;
      });
    }
    return error;
  }

  void _submitProgressForm(BuildContext context, ViewModel viewModel)
  {
    if(!_checkError()) {
      GoalProgress newProgress = GoalProgress(
        progress: double.parse(amountController.text), 
        dateString: _selectedDate == null ?  "${DateUtils.dateOnly(DateTime.now())}" : "${DateUtils.dateOnly(_selectedDate!)}",
        id: widget.progressId, 
        goalId: widget.goal.goalId
      );
      if(widget.progressId == -1) {
        viewModel.createProgress(widget.goal, newProgress);
      }
      else {
        viewModel.updateProgress(newProgress);
      }
      
      Navigator.of(context).pop();
    }
    
  }

  void _deleteProgressConfirm(BuildContext context, ViewModel viewModel)
  {
    showDialog(
      context: context, 
      builder: (BuildContext context) {
        return ConfirmationWindow(
          onConfirmAction: () {_deleteProgress(context, viewModel);}
        );
      }
    );
  }


  void _deleteProgress(BuildContext context, ViewModel viewModel)
  {
    viewModel.deleteProgress(widget.progressId, widget.goal.goalId);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
   showDatePicker(
    context: context,
    initialDate: widget.startDate, 
    firstDate: DateTime.now().subtract(Duration(days: 1460)), 
    lastDate: DateTime.now()
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      else {
       
        setState(() {
          _selectedDate = pickedDate;
        });
      }
      
    }); 
  }

  

  @override
  Widget build(BuildContext context) {
    amountController.text = amountController.text == "" ? widget.startUnits == 0 ? "" : widget.startUnits.toString() : amountController.text; 
    _selectedDate = _selectedDate == null ? widget.startDate : _selectedDate;
    return StoreConnector<AppState, ViewModel>(
      converter: (Store<AppState> store) => ViewModel.create(store),
      builder: (BuildContext context, ViewModel viewModel){
        return AlertDialog(
          scrollable: true,
          title: Text(widget.goal.goalName),
          content: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Column(
              children: <Widget>[
                error ? const Text("Amounts must be numbers.", style: appStyle.AppThemes.errorText) : SizedBox(height: 14),
                Row(
                  children: <Widget>[
                    const Text("Completed", style: TextStyle(fontSize: 14),),
                    const SizedBox(width: 4), 
                    Container(
                      width: 100,
                      child: TextField(
                        controller: amountController,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        style: TextStyle(fontSize: 16),
                      
                      ),
                    ),
                    Text(widget.goal.goalUnits + "(s)", style: TextStyle(fontSize: 14),)
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  children: <Widget>[
                    Text("On", style: TextStyle(fontSize: 16),),
                    SizedBox(width: 4), 
                    GestureDetector(
                      onTap: _presentDatePicker,
                      child: Container(
                        child: Text(
                          _selectedDate == null ? '${DateFormat.yMd().format(widget.startDate)}' : '${DateFormat.yMd().format(_selectedDate!)}', 
                          style: TextStyle(fontSize: 16, color: Colors.deepPurple),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 25,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(onPressed: () {Navigator.of(context).pop();}, child: Text('Cancel')),
                    SizedBox(width: 20),
                    ElevatedButton(onPressed: () {
                      _submitProgressForm(context,viewModel);
                    }, 
                      child: Text('Submit')
                    ),
                  ],
                ),
                widget.includeDelete ? SizedBox(
                  width: 220,
                  child: ElevatedButton(
                    onPressed: () {_deleteProgressConfirm(context, viewModel);}, 
                    child: Text("Delete Event"),
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                  ),
                ) : SizedBox(height: 0, width: 0),
              ],
            )
          )
        );
      }
    );
  }
}