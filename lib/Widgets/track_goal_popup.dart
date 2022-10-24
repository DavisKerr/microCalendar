import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';

import '../Model/goal.dart';
import '../Model/goal_progress.dart';
import '../Actions/goal_actions.dart';

import 'package:redux/redux.dart';

import '../State/app_state.dart';
import '../View/view_model.dart';

class TrackGoalPopup extends StatefulWidget {
  final Goal goal;
  final Function submitForm;
  final Function deleteAction;
  final bool includeDelete;
  final DateTime startDate;
  final double startUnits;

  const TrackGoalPopup({
    required this.goal, 
    required this.submitForm, 
    required this.startDate, 
    required this.startUnits, 
    required this.deleteAction,
    required this.includeDelete,
  });

  @override
  State<TrackGoalPopup> createState() => _TrackGoalPopupState();
}

class _TrackGoalPopupState extends State<TrackGoalPopup> {
  final TextEditingController amountController = TextEditingController();

  DateTime? _selectedDate;

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
                      widget.submitForm(double.parse(amountController.text) as double, 
                        _selectedDate == null ?  "${DateUtils.dateOnly(DateTime.now())}" : "${DateUtils.dateOnly(_selectedDate!)}",
                        widget.goal,
                        context,
                        viewModel
                      );
                    }, 
                      child: Text('Submit')
                    ),
                  ],
                ),
                widget.includeDelete ? SizedBox(
                  width: 220,
                  child: ElevatedButton(
                    onPressed: () {widget.deleteAction(viewModel, context);}, 
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