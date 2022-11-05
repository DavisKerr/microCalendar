import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:micro_calendar/Widgets/ActivityLogWidgets/progress_box.dart';
import 'package:redux/redux.dart';

import '../../Model/goal.dart';
import '../../Model/goal_progress.dart';
import '../../State/app_state.dart';
import '../../View/view_model.dart';

class ProgressList extends StatelessWidget {
  final Goal goal;
  const ProgressList({required this.goal});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      converter: (Store<AppState> store) => ViewModel.create(store),
      builder: (BuildContext context, ViewModel viewModel) {
        Iterable<GoalProgress> items = viewModel.goalList.where((i) => i.goalId == goal.goalId).first.goalProgress;
        return Container (
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items.elementAt(index);
              return ProgressBox(progress: item, units: goal.goalUnits, goal: goal, viewModel: viewModel,);
            },
          ),
        );
      }
    );
  }
}