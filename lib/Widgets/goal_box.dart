import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:micro_calendar/View/view_model.dart';
import 'package:micro_calendar/Widgets/large_goal_menu_button.dart';
import 'package:micro_calendar/Widgets/track_goal_popup.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:time_machine/time_machine.dart';


import '../Actions/goal_actions.dart';
import '../State/app_state.dart';
import '../Model/goal.dart';
import '../Model/goal_progress.dart';
import '../Widgets/horizontal_progress_bar.dart';
import '../SpawnPopups/spawn_popups.dart';

class GoalBox extends StatelessWidget {

  final Goal goal;
  final Function viewActivityLog;
  final double maxHeight;
  final double maxWidth;

  GoalBox({required this.goal, 
    required this.maxHeight,
    required this.maxWidth,
    required this.viewActivityLog,  
  });

  int daysLeft(String endString)
  {
    DateTime now = DateTime.now();
    DateTime end = DateTime.parse(endString);
    now = DateTime(now.year, now.month, now.day);
    end = DateTime(end.year, end.month, end.day);
    return (end.difference(now).inHours / 24).round();
  }

  bool goalComplete(Goal goal) {
    return DateTime.now().isAfter(DateTime.parse(goal.goalEndDate)) || goal.progressPercentage > 0.995;
  }

  // double calculateTotal(Goal goal)
  // {
  //   double factor = 0;
  //   if(goal.goalPeriod == PeriodUnit.day)
  //   {
  //     factor = LocalDate.dateTime(DateTime.parse(goal.goalEndDate)).periodSince(LocalDate.dateTime(DateTime.parse(goal.goalStartDate))).days.toDouble();
  //   }
  //   else if(goal.goalPeriod == PeriodUnit.week)
  //   {
  //     factor = LocalDate.dateTime(DateTime.parse(goal.goalEndDate)).periodSince(LocalDate.dateTime(DateTime.parse(goal.goalStartDate))).days.toDouble() / 7;
  //     print(factor);
  //   }
  //   else 
  //   {
  //     factor = LocalDate.dateTime(DateTime.parse(goal.goalEndDate)).periodSince(LocalDate.dateTime(DateTime.parse(goal.goalStartDate))).months.toDouble();
  //   }

  //   return (goal.goalQuantity * factor);
  // }

  // void _submitProgressForm(double units, String date, Goal goal, BuildContext context, ViewModel viewModel)
  // {
  //   GoalProgress newProgress = GoalProgress(progress: units, dateString: date, id: -1, goalId: goal.goalId);
  //   viewModel.createProgress(goal, newProgress);
  //   Navigator.of(context).pop();
  // }

  // double calculateProgress(Goal goal, ViewModel viewModel)
  // {
  //   Iterable<GoalProgress> progress = viewModel.goalProgress.where((element) => element.goalId == goal.goalId);
  //   return progress.fold(0.0, (double prev, GoalProgress element) => prev + element.progress);
  // }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
       converter: (Store<AppState> store) => ViewModel.create(store),
        builder: (BuildContext context, ViewModel viewModel) {
          return Container(
            height: 175,
            child: Card(
              margin: EdgeInsets.only(left: 20, bottom:20, top:20, right: 20),
              color: Theme.of(context).cardColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 175,
                    width: maxWidth * 0.75,
                    child: GestureDetector(
                      onTap: () {startGoalTracker(context, goal, DateTime.now(),);},
                      onLongPress: () {startGoalEditor(context, goal, viewModel);},
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
                            HorizontalProgressBar(
                              percentage: goal.progressPercentage, 
                            ),
                            goalComplete(goal) ? 
                            ElevatedButton(onPressed: () {
                              Goal newGoal = Goal(
                                goalName: goal.goalName, 
                                goalVerb: goal.goalVerb, 
                                goalQuantity: goal.goalQuantity, 
                                goalUnits: goal.goalUnits, 
                                goalPeriod: goal.goalPeriod, 
                                goalStartDate: goal.goalStartDate, 
                                goalEndDate: goal.goalEndDate, 
                                goalId: goal.goalId, 
                                progressPercentage: goal.progressPercentage,
                                complete: true
                                );
                              viewModel.updateGoal(newGoal);
                            }, 
                            child: Text("Complete!")) : 
                            SizedBox(),
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
                      viewActivityLog: viewActivityLog,
                      viewModel: viewModel,
                    )
                  ),
                ],
              ),
            ),
          );
        }
    );
    

  }
}