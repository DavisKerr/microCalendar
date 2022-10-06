import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:micro_calendar/Widgets/large_goal_menu_button.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';


import '../State/app_state.dart';
import '../Model/goal.dart';
import '../Model/goal_progress.dart';
import '../Widgets/horizontal_progress_bar.dart';

class GoalBox extends StatelessWidget {

  final Goal goal;
  final Function onGoalBoxClick;
  final Function onGoalBoxLongClick;
  final Store store;
  final double maxHeight;
  final double maxWidth;

  GoalBox({required this.goal, 
    required this.onGoalBoxClick, 
    required this.onGoalBoxLongClick, 
    required this.store, 
    required this.maxHeight,
    required this.maxWidth});

  int daysLeft(String endString)
  {
    DateTime now = DateTime.now();
    DateTime end = DateTime.parse(endString);
    now = DateTime(now.year, now.month, now.day);
    end = DateTime(end.year, end.month, end.day);
    return (end.difference(now).inHours / 24).round();
  }


  double calculateProgress(Goal goal)
  {
    return goal.progress!.fold(0.0, (double prev, GoalProgress element) => prev + element.progress);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Card(
        margin: EdgeInsets.only(left: 20, bottom:20, top:20, right: 20),
        color: Theme.of(context).cardColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 150,
              width: maxWidth * 0.75,
              child: GestureDetector(
                onTap: () {onGoalBoxClick(context, store, goal);},
                onLongPress: () {onGoalBoxLongClick(context, store, goal);},
                child: Card(
                  elevation: 0,
                  margin: EdgeInsets.all(0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        goal.goalName,
                        style: Theme.of(context).textTheme.titleMedium
                      ),
                      Text("Ends in " + daysLeft(goal.goalEndDate).toString() + " days"),
                      HorizontalProgressBar(total: goal.goalQuantity, current: calculateProgress(this.goal)),
                    ],
                  ),
                ),
              ),
            ),
            Flexible(
              child: LargeGoalMenuButton(
                height: maxHeight, 
                width: maxWidth * 0.25,
                goal: goal,
                editGoal: onGoalBoxLongClick,
                trackGoal: onGoalBoxClick,
                store: store
              )
            ),
          ],
        ),
      ),
    );

  }
}