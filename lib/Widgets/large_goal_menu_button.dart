import 'package:flutter/material.dart';
import 'package:micro_calendar/SpawnPopups/spawn_popups.dart';
import 'package:micro_calendar/View/view_model.dart';
import 'package:micro_calendar/Widgets/text_popup_menu.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../Actions/goal_actions.dart';
import '../Model/goal.dart';

class LargeGoalMenuButton extends StatelessWidget {
  
  final double height;
  final double width;
  final Goal goal;
  final Function viewActivityLog;
  final ViewModel viewModel;

  const LargeGoalMenuButton({
    required this.height, 
    required this.width, 
    required this.goal,
    required this.viewActivityLog,
    required this.viewModel
  });

  _openTrackerMenu(BuildContext context)
  {
    startGoalTracker(context, goal, DateTime.now(),);
  }

  _openEditorMenu(BuildContext context)
  {
    startGoalEditor(context, goal, viewModel);
  }

  _openActivityLog(BuildContext context)
  {
    viewModel.navigateToActivityLogScreen(goal);
  }

  _openNotificationEditMenu(BuildContext context)
  {
    startNotificationEditor(context, goal, viewModel);
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
              _openTrackerMenu(context);
            }
            else if(value == 1) {
              _openEditorMenu(context);
            }
            else if(value == 2) {
              _openNotificationEditMenu(context);
            }
            else if(value == 3) {
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
