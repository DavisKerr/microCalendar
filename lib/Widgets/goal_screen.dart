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
  

  const GoalScreen();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
            converter: (Store<AppState> store) => ViewModel.create(store),
            builder: (BuildContext context, ViewModel viewModel) {
              Iterable<Goal> nonCompleteGoals = viewModel.goalList.where((goal) => !goal.complete);
        return Container(
          height: viewModel.maxHeight,
          width: viewModel.maxWidth,
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: viewModel.maxHeight * 0.9,
                width: viewModel.maxWidth,
                child: ListView.builder(
                  itemCount: nonCompleteGoals.length + 1,
                  itemBuilder: (context, index) {
                    if(index < nonCompleteGoals.length)
                    {
                      final item = nonCompleteGoals.elementAt(index);
                      return Container(
                        child: GoalBox(
                          goal: item, 
                          viewActivityLog: viewModel.navigateToActivityLogScreen,
                        ),
                      );
                    }
                    return AddGoalButton();
                  },
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}