import 'package:flutter/material.dart';
import 'package:micro_calendar/Model/goal_progress.dart';
import 'package:micro_calendar/SpawnPopups/spawn_popups.dart';
import 'package:micro_calendar/View/view_model.dart';
import 'package:micro_calendar/Widgets/text_popup_menu.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../Actions/goal_actions.dart';
import '../Model/goal.dart';
import '../State/app_state.dart';

class LargeCompletedGoalMenuButton extends StatelessWidget {
  
  final Goal goal;

  const LargeCompletedGoalMenuButton({
    required this.goal,
  });

  _unmarkGoalComplete(BuildContext context, ViewModel viewModel)
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

  _openActivityLog(BuildContext context, ViewModel viewModel)
  {
    viewModel.navigateToActivityLogScreen(goal);
  }

  _openDeleteGoalConfirmationWindow(BuildContext context, ViewModel viewModel)
  {
    startConfirmationWindow(context, goal, () {_deleteGoal(viewModel);});
  }

  void _deleteGoal(ViewModel viewModel) {
    viewModel.deleteGoal(goal);
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      converter: (Store<AppState> store) => ViewModel.create(store),
      builder: (BuildContext context, ViewModel viewModel) {
        return Card(
          margin: EdgeInsets.all(0),
          color: Color.fromARGB(100, 236, 234, 231),
          elevation: 0,
          child: SizedBox(
            height: viewModel.maxHeight,
            width: viewModel.maxWidth,
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
                  _unmarkGoalComplete(context, viewModel);
                }
                else if(value == 1) {
                  _openActivityLog(context, viewModel);
                }
                else {
                  _openDeleteGoalConfirmationWindow(context, viewModel);
                }
              },
            ),
          ),
        );
      }
    );
  }
}
