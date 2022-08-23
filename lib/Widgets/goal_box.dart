import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';

import '../State/app_state.dart';
import '../Model/goal.dart';

class GoalBox extends StatelessWidget {

  final Goal? goal;

  GoalBox({required this.goal});

  int daysLeft(String endString)
  {
    DateTime now = DateTime.now();
    DateTime end = DateTime.parse(endString);
    now = DateTime(now.year, now.month, now.day);
    end = DateTime(end.year, end.month, end.day);
    return (end.difference(now).inHours / 24).round();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(20),
      color: Theme.of(context).cardColor,
      child: Column(
        children: <Widget>[
          Text(
            goal!.goalName,
            style: Theme.of(context).textTheme.titleMedium
          ),
          Text("Ends in " + daysLeft(goal!.goalEndDate).toString() + " days")
        ],
      ),
    );
  }
}