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
  final Function trackGoal;
  final Function viewActivityLog;
  final ViewModel viewModel;

  const LargeGoalMenuButton({
    required this.height, 
    required this.width, 
    required this.goal,
    required this.trackGoal,
    required this.viewActivityLog,
    required this.viewModel
  });

  _openTrackerMenu(BuildContext context)
  {
    Navigator.of(context).pop();
    startGoalTracker(context, goal, trackGoal, DateTime.now(), (){});
    showDialog(context: context,
      builder: (BuildContext context) {
        return Container();
    });
  }

  _openEditorMenu(BuildContext context)
  {
    Navigator.of(context).pop();
    startGoalEditor(context, goal, viewModel);
    showDialog(context: context,
      builder: (BuildContext context) {
        return Container();
    });
  }

  _openActivityLog(BuildContext context)
  {
    Navigator.of(context).pop();
    viewActivityLog(context, goal);
    showDialog(context: context,
      builder: (BuildContext context) {
        return Container();
    });
  }

  _openDeleteGoalConfirmationWindow(BuildContext context)
  {
    Navigator.of(context).pop();
    startConfirmationWindow(context, goal, _deleteGoal);
    showDialog(context: context,
      builder: (BuildContext context) {
        return Container();
    });
  }

  void _deleteGoal(BuildContext context) {
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
          icon: Icon(Icons.more_vert),
          itemBuilder: (BuildContext context) => <PopupMenuEntry>[
            PopupMenuItem(
              onTap: () {_openTrackerMenu(context);},
              child: const ListTile(
                leading: Icon(Icons.check_box),
                title: Text('Track Goal'),
              ),
            ),
            PopupMenuItem(
              onTap: () {_openEditorMenu(context);},
              child: const ListTile(
                leading: Icon(Icons.edit),
                title: Text('Edit Goal'),
              ),
            ),
            const PopupMenuDivider(),
            PopupMenuItem(
              onTap: () {_openActivityLog(context);},
              child: const ListTile(
                leading: Icon(Icons.view_agenda),
                title: Text('Activity Log'),
              ),
            ),
            PopupMenuItem(
              onTap: () {_openDeleteGoalConfirmationWindow(context);},
              child: const ListTile(
                leading: Icon(Icons.delete),
                title: Text('Delete Goal'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
