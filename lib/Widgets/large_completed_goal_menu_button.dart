import 'package:flutter/material.dart';
import 'package:micro_calendar/Model/goal_progress.dart';
import 'package:micro_calendar/SpawnPopups/spawn_popups.dart';
import 'package:micro_calendar/View/view_model.dart';
import 'package:micro_calendar/Widgets/text_popup_menu.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../Actions/goal_actions.dart';
import '../Model/goal.dart';

class LargeCompletedGoalMenuButton extends StatelessWidget {
  
  final double height;
  final double width;
  final Goal goal;
  final ViewModel viewModel;

  const LargeCompletedGoalMenuButton({
    required this.height, 
    required this.width, 
    required this.goal,
    required this.viewModel
  });

  _unmarkGoalComplete(BuildContext context)
  {
    Goal newGoal = Goal(
      goalName: goal.goalName, 
      goalVerb: goal.goalVerb, 
      goalQuantity: goal.goalQuantity, 
      goalUnits: goal.goalUnits, 
      goalPeriod: goal.goalPeriod, 
      goalStartDate: goal.goalStartDate, 
      goalEndDate: goal.goalEndDate, 
      goalId: goal.goalId, 
      goalProgress: goal.goalProgress,
      progressPercentage: goal.progressPercentage,
      complete: false
    );

    viewModel.unCompleteGoal(newGoal);
  }

  _openActivityLog(BuildContext context)
  {
    viewModel.navigateToActivityLogScreen(goal);
  }

  _openDeleteGoalConfirmationWindow(BuildContext context)
  {
    startConfirmationWindow(context, goal, _deleteGoal);
  }

  void _deleteGoal() {
    viewModel.deleteGoal(goal);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(0),
      color: Color.fromARGB(100, 236, 234, 231),
      elevation: 0,
      child: SizedBox(
        height: height,
        width: width,
        child: PopupMenuButton(
          
          color: Color.fromARGB(255, 255, 255, 255),
          iconSize: 30,
          icon: const Icon(Icons.more_vert),
          itemBuilder: (BuildContext context) => <PopupMenuEntry>[
            const PopupMenuItem(
              value: 0,
              child: ListTile(
                leading: Icon(Icons.check_box),
                title: Text('Mark Goal Not Complete'),
              ),
            ),
            const PopupMenuItem(
              value: 1,
              child: ListTile(
                leading: Icon(Icons.view_agenda),
                title: Text('Activity Log'),
              ),
            ),
            const PopupMenuItem(
              value: 2,
              child: ListTile(
                leading: Icon(Icons.delete),
                title: Text('Delete'),
              ),
            ),
          ],

          onSelected: (value) {
            if(value == 0) {
              _unmarkGoalComplete(context);
            }
            else if(value == 1) {
              _openActivityLog(context);
            }
            else {
              _openDeleteGoalConfirmationWindow(context);
            }
          },
        ),
      ),
    );
  }
}
