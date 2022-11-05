import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:redux/redux.dart';

import '../../Actions/goal_actions.dart';
import '../../Model/goal.dart';
import '../../Model/goal_progress.dart';
import '../../SpawnPopups/spawn_popups.dart';
import '../../State/app_state.dart';
import '../../View/view_model.dart';
import '../confirmation_window.dart';

class ProgressBox extends StatelessWidget {
  final GoalProgress progress;
  final Goal goal;
  final String units;
  final ViewModel viewModel;
  const ProgressBox({required this.progress, required this.units, required this.goal, required this.viewModel});

  // void _submitProgressForm(double units, String date, Goal goal, BuildContext context, ViewModel viewModel)
  // {
  //   GoalProgress newProgress = GoalProgress(progress: units, dateString: date, id: progress.id, goalId: goal.goalId);
  //   viewModel.editProgress(goal, newProgress);
  //   Navigator.of(context).pop();
  // }

  // void _deleteProgressConfirm(BuildContext context)
  // {
  //   showDialog(
  //     context: context, 
  //     builder: (BuildContext context) {
  //       return ConfirmationWindow(onConfirmAction: _deleteProgress);}
  //   );
  // }

  // void _deleteProgress(BuildContext context)
  // {
  //   viewModel.deleteProgress(progress);
  //   Navigator.of(context).pop();
  // }

  @override
  Widget build(BuildContext context) {

    return StoreConnector<AppState, ViewModel>(
        converter: (Store<AppState> store) => ViewModel.create(store),
        builder: (BuildContext context, ViewModel viewModel) {
          return Container(
            height: 75,
            padding: EdgeInsets.all(5),
            child: GestureDetector(
              onTap: () {!goal.complete ? startGoalTracker(context, goal,  DateTime.parse(progress.dateString), progress.progress, true, progress.id) : 1;},
              child: Card(
                margin: EdgeInsets.only(left: 10, bottom:10, top:10, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Tracked ${progress.progress} $units(s)"),
                    Text("on ${DateFormat.yMd().format(DateTime.parse(progress.dateString))}"),
                  ],
                ),
              ),
            ),
          );
        }
      );
    
    
  }
}

