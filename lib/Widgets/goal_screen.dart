import 'package:micro_calendar/Widgets/goal_box.dart';
import 'package:redux/redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../Model/goal.dart';
import '../State/app_state.dart';
import '../Widgets/add_goal_button.dart';


class GoalScreen extends StatelessWidget {
  
  final Store store;
  final Function trackGoalFunction;
  final Function editGoalFunction;
  final Function changeToCreateGoalScreen;
  final double maxHeight;
  final double maxWidth;

  const GoalScreen({
    required this.store, 
    required this.trackGoalFunction, 
    required this.editGoalFunction, 
    required this.maxHeight,
    required this.maxWidth,
    required this.changeToCreateGoalScreen});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text('Goals', textAlign: TextAlign.center, style: TextStyle(fontSize: 24),),
          StoreConnector<AppState, Iterable<Goal>>(
              converter: (store) => store.state.goalList,
              builder: (context, items) {
                return Container(
                  height: maxHeight * 0.85,
                  width: maxWidth * 0.9,
                  child: ListView.builder(
                    itemCount: items.length + 1,
                    itemBuilder: (context, index) {
                      if(index < items.length)
                      {
                        final item = items.elementAt(index);
                        return Container(
                          //height: (maxHeight * 0.85) * 0.20,
                          child: GoalBox(
                            goal: item, 
                            onGoalBoxClick: trackGoalFunction, 
                            onGoalBoxLongClick: editGoalFunction,
                            store: store,
                            maxWidth: maxWidth, 
                            maxHeight: maxHeight),
                        );
                      }
                      return AddGoalButton(changeToGoalScreen: changeToCreateGoalScreen, store: store);
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