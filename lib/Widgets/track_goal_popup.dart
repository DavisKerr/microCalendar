import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Model/goal.dart';
import '../Model/goal_progress.dart';
import '../Actions/goal_actions.dart';

import 'package:redux/redux.dart';

class TrackGoalPopup extends StatefulWidget {
  final Goal goal;
  final Store store; 

  const TrackGoalPopup({required this.goal, required this.store});

  @override
  State<TrackGoalPopup> createState() => _TrackGoalPopupState();
}

class _TrackGoalPopupState extends State<TrackGoalPopup> {
  final amountController = TextEditingController();
  DateTime? _selectedDate;

  void _presentDatePicker() {
   showDatePicker(
    context: context,
    initialDate: DateTime.now(), 
    firstDate: DateTime(2019), 
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

  void _submitForm(double units, String date)
  {
    widget.store.dispatch(
      AddGoalProgressAction(widget.goal, 
        GoalProgress(progress: double.parse(amountController.text) as double, 
        dateString: _selectedDate == null ?  DateFormat.yMd().format(DateTime.now()) : DateFormat.yMd().format(_selectedDate!))
      )
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Text(widget.goal.goalName),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                const Text("Completed", style: TextStyle(fontSize: 16),),
                const SizedBox(width: 4), 
                Container(
                  width: 100,
                  child: TextField(
                    controller: amountController,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(fontSize: 16),
                  
                  ),
                ),
                Text(widget.goal.goalUnits, style: TextStyle(fontSize: 16),)
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
                      _selectedDate == null ? 'Today: ${DateFormat.yMd().format(DateTime.now())}' : '${DateFormat.yMd().format(_selectedDate!)}', 
                      style: TextStyle(fontSize: 16, color: Colors.deepPurple),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 25,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(onPressed: () {Navigator.of(context).pop();}, child: Text('Cancel')),
                SizedBox(width: 20),
                ElevatedButton(onPressed: () {
                  _submitForm(double.parse(amountController.text) as double, 
                    _selectedDate == null ?  
                      DateFormat.yMd().format(DateTime.now()) : DateFormat.yMd().format(_selectedDate!));
                }, 
                  child: Text('Submit')
                ),
              ],
            )
          ],
        )
      )
    );
  }
}