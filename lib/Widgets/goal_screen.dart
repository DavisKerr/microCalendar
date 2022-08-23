import 'package:micro_calendar/Widgets/goal_box.dart';
import 'package:redux/redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../Model/goal.dart';
import '../State/app_state.dart';


class GoalScreen extends StatelessWidget {
  
  final Store store;

  const GoalScreen({required this.store});

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
                return Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items.elementAt(index);
                      return GoalBox(goal: item);
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