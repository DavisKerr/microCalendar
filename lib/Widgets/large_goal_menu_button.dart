import 'package:flutter/material.dart';
import 'package:micro_calendar/SpawnPopups/spawn_popups.dart';
import 'package:micro_calendar/View/view_model.dart';
import 'package:micro_calendar/Widgets/text_popup_menu.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../Actions/goal_actions.dart';
import '../Model/goal.dart';
import '../State/app_state.dart';

class LargeGoalMenuButton extends StatelessWidget {
  
  final Goal goal;
  final Function viewActivityLog;

  const LargeGoalMenuButton({
    required this.goal,
    required this.viewActivityLog,
  });

  _openTrackerMenu(BuildContext context, ViewModel viewModel)
  {
    startGoalTracker(context, goal, DateTime.now(),);
  }

  _openEditorMenu(BuildContext context, ViewModel viewModel)
  {
    startGoalEditor(context, goal, viewModel);
  }

  _openActivityLog(BuildContext context, ViewModel viewModel)
  {
    viewModel.navigateToActivityLogScreen(goal);
  }

  _openNotificationEditMenu(BuildContext context, ViewModel viewModel)
  {
    startNotificationEditor(context, goal, viewModel);
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
            height: 175,
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
                    title: Text('Track Goal'),
                  ),
                ),
                const PopupMenuItem(
                  value: 1,
                  child: ListTile(
                    leading: Icon(Icons.edit),
                    title: Text('Edit Goal'),
                  ),
                ),
                const PopupMenuItem(
                  value: 2,
                  child: ListTile(
                    leading: Icon(Icons.notifications_on),
                    title: Text('Edit Notifications'),
                  ),
                ),
                const PopupMenuDivider(),
                const PopupMenuItem(
                  value: 3,
                  child: ListTile(
                    leading: Icon(Icons.view_agenda),
                    title: Text('Activity Log'),
                  ),
                ),
                const PopupMenuItem(
                  value: 4,
                  child: ListTile(
                    leading: Icon(Icons.delete),
                    title: Text('Delete Goal'),
                  ),
                ),
              ],

              onSelected: (value) {
                if(value == 0) {
                  _openTrackerMenu(context, viewModel);
                }
                else if(value == 1) {
                  _openEditorMenu(context, viewModel);
                }
                else if(value == 2) {
                  _openNotificationEditMenu(context, viewModel);
                }
                else if(value == 3) {
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
