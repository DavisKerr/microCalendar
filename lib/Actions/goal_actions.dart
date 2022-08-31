import 'package:flutter/material.dart';

import 'action.dart' as AppAction;
import '../Model/goal.dart';
import '../Model/goal_progress.dart';

@immutable
abstract class GoalAction extends AppAction.Action {
  final Goal goal;

  const GoalAction(this.goal);
}

@immutable 
class AddGoalProgressAction extends GoalAction {
  final GoalProgress newProgress;
  const AddGoalProgressAction(Goal goal, this.newProgress) : super(goal); 
}
