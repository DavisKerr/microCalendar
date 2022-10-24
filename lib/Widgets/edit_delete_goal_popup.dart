import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:micro_calendar/Widgets/confirmation_window.dart';


import '../Model/goal.dart';
import '../Model/goal_progress.dart';
import '../Actions/goal_actions.dart';
import '../State/app_state.dart';
import '../View/view_model.dart';
import '../Widgets/number_wheel_selector.dart';

import 'package:redux/redux.dart';

class EditDeleteGoalPopup extends StatefulWidget {
  final Goal goal;
  final ViewModel viewModel;

  const EditDeleteGoalPopup({required this.goal, required this.viewModel});

  @override
  State<EditDeleteGoalPopup> createState() => _EditDeleteGoalPopupState();
}

class _EditDeleteGoalPopupState extends State<EditDeleteGoalPopup> {

  final nameController = TextEditingController();
  final verbController = TextEditingController();
  final quantityController = TextEditingController();
  final unitsController = TextEditingController();
  
  PeriodUnit? _periodController;
  DateTime? _goalEndDate;

  void _presentDatePicker() {
   showDatePicker(
    context: context,
    initialDate: _goalEndDate != null ? _goalEndDate! : DateTime.now(), 
    firstDate: DateTime(2019), 
    lastDate: DateTime(2024),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      else {
       
        setState(() {
          _goalEndDate = pickedDate;
        });
      }
      
    }); 
  }

  void _deleteGoal(BuildContext context) {
    widget.viewModel.deleteGoal(widget.goal);
    Navigator.of(context).pop();
  }

  void _deleteGoalConfirm()
  {
    showDialog(
      context: context, 
      builder: (BuildContext context) {
        return ConfirmationWindow(onConfirmAction: _deleteGoal);}
    );
  }

  void _changePeriod(PeriodUnit newPeriod)
  {
    setState(() {
          _periodController = newPeriod;
        });
  }

  void _submitForm()
  {
    Goal goal = Goal(
      goalName: nameController.text,
      goalVerb: verbController.text,
      goalQuantity: double.parse(quantityController.text),
      goalUnits: unitsController.text,
      goalStartDate: widget.goal.goalStartDate,
      goalEndDate: _goalEndDate.toString(),
      goalPeriod: _periodController!,
      goalId: widget.goal.goalId,
      progressPercentage: widget.goal.progressPercentage,
    );
    widget.viewModel.editGoal(goal);
    Navigator.of(context).pop();
  }

  

  @override
  Widget build(BuildContext context) {

    nameController.text = nameController.text == '' ? widget.goal.goalName : nameController.text;
    verbController.text = verbController.text == '' ? widget.goal.goalVerb : verbController.text;
    quantityController.text = quantityController.text == '' ? widget.goal.goalQuantity.toString() : quantityController.text;
    unitsController.text = unitsController.text == '' ? widget.goal.goalUnits : unitsController.text;
    _goalEndDate = _goalEndDate != null ? _goalEndDate : DateTime.parse(widget.goal.goalEndDate);
    _periodController = _periodController != null ? _periodController : widget.goal.goalPeriod;
    const List<String> periodController = <String>['Day', 'Month', 'Year'];

    return AlertDialog(
      scrollable: true,
      title: Text('Edit ${widget.goal.goalName}'),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child:  SingleChildScrollView(
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: "Goal Name", hintText: "Goal Name"),
                  controller: nameController,
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Goal Verb", hintText: "Goal Verb"),
                  controller: verbController,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "Goal Quantity", hintText: "Goal Quantity"),
                  controller: quantityController,
                ),
                TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: "Goal Units", hintText: "Goal Units"),
                  controller: unitsController,
                ),
                Text("Period"),
                DropdownButton<PeriodUnit>(
                  
                  items: PeriodUnit.values.map((PeriodUnit classType) {
                    return DropdownMenuItem<PeriodUnit>(
                      value: classType,
                      child: Text(classType.toString().split('.')[1].toString()));
                  }).toList(),
                  onChanged: (option) {_changePeriod(option!);},
                  value: _periodController,
                ),
                Text("End Date:"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: _presentDatePicker,
                      child: Container(
                        child: Text(
                        '${DateFormat.yMd().format(_goalEndDate!)}', 
                          style: TextStyle(fontSize: 16, color: Colors.deepPurple),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(onPressed: () {Navigator.of(context).pop();}, child: Text("Cancel")),
                    ElevatedButton(onPressed: _submitForm, child: Text("Confirm")),
                  ],
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 220,
                  child: ElevatedButton(
                    onPressed: _deleteGoalConfirm, 
                    child: Text("Delete Goal"),
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                  ),
                ),

              ],
            )
          )
        )
      )
    );
    
  }
}