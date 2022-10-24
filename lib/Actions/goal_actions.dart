import 'package:flutter/material.dart';
import 'package:micro_calendar/Model/goal_progress.dart';

import 'action.dart' as AppAction;
import '../Model/goal.dart';

@immutable
abstract class GoalAction extends AppAction.Action {
  final Goal goal;

  const GoalAction(this.goal);
}

@immutable 
class DeleteGoalAction extends GoalAction {
  const DeleteGoalAction(Goal goal) : super(goal);
}

@immutable 
class ModifyGoalAction extends GoalAction {
  const ModifyGoalAction(Goal goal) : super(goal);
}

@immutable 
class AddGoalAction extends GoalAction {
  const AddGoalAction(Goal goal) : super(goal);
}

@immutable 
class UpdateProgressPercentageAction extends GoalAction {
  const UpdateProgressPercentageAction(Goal goal) : super(goal);
}

@immutable 
class AddGoalProgressAction extends GoalAction {
  final GoalProgress progress;
  const AddGoalProgressAction(Goal goal, this.progress) : super(goal);
}

@immutable 
class UpdateGoalProgressAction extends GoalAction {
  final GoalProgress progress;
  const UpdateGoalProgressAction(Goal goal, this.progress) : super(goal);
}

@immutable 
class DeleteGoalProgressAction extends GoalAction {
  final GoalProgress progress;
  const DeleteGoalProgressAction(Goal goal, this.progress) : super(goal);
}


