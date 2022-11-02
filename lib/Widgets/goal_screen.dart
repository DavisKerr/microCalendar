import 'package:micro_calendar/View/view_model.dart';
import 'package:micro_calendar/Widgets/goal_box.dart';
import 'package:redux/redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../Actions/goal_actions.dart';
import '../Model/goal.dart';
import '../Model/goal_progress.dart';
import '../State/app_state.dart';
import '../Widgets/add_goal_button.dart';


class GoalScreen extends StatelessWidget {
  
  final Function changeToCreateGoalScreen;
  final Function changeToActivityLogScreen;
  final double maxHeight;
  final double maxWidth;

  const GoalScreen({
    required this.maxHeight,
    required this.maxWidth,
    required this.changeToCreateGoalScreen,
    required this.changeToActivityLogScreen
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text('Goals', textAlign: TextAlign.center, style: TextStyle(fontSize: 24),),
          StoreConnector<AppState, ViewModel>(
            converter: (Store<AppState> store) => ViewModel.create(store),
            builder: (BuildContext context, ViewModel viewModel) {
              Iterable<Goal> nonCompleteGoals = viewModel.goalList.where((goal) => !goal.complete);
              return Container(
                height: maxHeight * 0.85,
                width: maxWidth * 0.9,
                child: ListView.builder(
                  itemCount: nonCompleteGoals.length + 1,
                  itemBuilder: (context, index) {
                    if(index < nonCompleteGoals.length)
                    {
                      final item = nonCompleteGoals.elementAt(index);
                      return Container(
                        //height: (maxHeight * 0.85) * 0.20,
                        child: GoalBox(
                          goal: item, 
                          maxWidth: maxWidth, 
                          maxHeight: maxHeight,
                          viewActivityLog: changeToActivityLogScreen,
                        ),
                      );
                    }
                    return AddGoalButton(changeToGoalScreen: changeToCreateGoalScreen);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}