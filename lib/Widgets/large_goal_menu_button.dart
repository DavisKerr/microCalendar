import 'package:flutter/material.dart';
import 'package:micro_calendar/SpawnPopups/spawn_popups.dart';
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
  final Function editGoal;
  final Store store;

  const LargeGoalMenuButton({
    required this.height, 
    required this.width, 
    required this.trackGoal, 
    required this.editGoal,
    required this.goal,
    required this.store,
  });

  _openTrackerMenu(BuildContext context)
  {
    Navigator.of(context).pop();
    trackGoal(context, store, goal);
    showDialog(context: context,
      builder: (BuildContext context) {
        return Container();
    });
  }

    _openEditorMenu(BuildContext context)
  {
    Navigator.of(context).pop();
    editGoal(context, store, goal);
    showDialog(context: context,
      builder: (BuildContext context) {
        return Container();
    });
  }

  _openDeleteGoalConfirmationWindow(BuildContext context)
  {
    Navigator.of(context).pop();
    startConfirmationWindow(context, store, goal, _deleteGoal);
    showDialog(context: context,
      builder: (BuildContext context) {
        return Container();
    });
  }

  void _deleteGoal(){
    store.dispatch(
      DeleteGoalAction(goal,)
    );
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
            const PopupMenuItem(
              child: ListTile(
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
    // return GestureDetector(
    //   onTapDown: (TapDownDetails details) => _startPopupMenu(context, details.globalPosition),
    //   child: Card(
    //     margin: EdgeInsets.all(0),
    //     color: Color.fromARGB(100, 236, 234, 231),
    //     elevation: 0,
    //     child: Container(
    //       width: width,
    //       height: 150,
    //       padding: EdgeInsets.only(top: 20, bottom: 20),
    //         child: Icon(Icons.menu_sharp),
    //     ),
    //   ),
    // );
  }
}
