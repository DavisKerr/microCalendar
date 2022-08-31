import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';


import '../State/app_state.dart';
import '../Model/goal.dart';
import '../Model/goal_progress.dart';
import '../Widgets/horizontal_progress_bar.dart';

class GoalBox extends StatelessWidget {

  final Goal goal;
  final Function onBoxClick;
  final Store store;

  GoalBox({required this.goal, required this.onBoxClick, required this.store});

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
    return GestureDetector(
      onTap: () {onBoxClick(context, store, goal);},
      onLongPress: () {print("Long Press!");},
      child: Container(
        height: 150,
        child: Card(
          margin: EdgeInsets.all(20),
          color: Theme.of(context).cardColor,
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
    );
  }
}