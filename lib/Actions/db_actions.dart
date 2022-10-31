import 'package:flutter/material.dart';
import 'package:micro_calendar/Model/goal_progress.dart';

import '../Model/goal.dart';
import 'action.dart' as AppAction;

@immutable
abstract class DBAction extends AppAction.Action{
  const DBAction();
}

@immutable
class LoadDataAttemptAction extends DBAction {
  const LoadDataAttemptAction();
}

@immutable
class LoadDataSuccessAction extends DBAction {
  final List<Goal> goals;
  final Iterable<GoalProgress> progress;
  const LoadDataSuccessAction(this.goals, this.progress);
}

@immutable
class InsertGoalProgressAttemptAction extends DBAction {
  final Goal goal;
  final GoalProgress progress;
  const InsertGoalProgressAttemptAction(this.goal, this.progress);
}

@immutable
class InsertGoalProgressSuccessAction extends DBAction {
  final int goalId;
  final int progressId;
  final GoalProgress progress;
  const InsertGoalProgressSuccessAction(this.goalId, this.progress, this.progressId);
}

@immutable
class DeleteGoalProgressAttemptAction extends DBAction {
  final int goalId;
  final int progressId;
  const DeleteGoalProgressAttemptAction(this.goalId, this.progressId);
}

@immutable
class DeleteGoalProgressSuccessAction extends DBAction {
  final int goalId;
  final int progressId;
  const DeleteGoalProgressSuccessAction(this.goalId, this.progressId);
}

@immutable
class UpdateGoalProgressAttemptAction extends DBAction {
  final GoalProgress newProgress;
  const UpdateGoalProgressAttemptAction(this.newProgress);
}

@immutable
class UpdateGoalProgressSuccessAction extends DBAction {
  final GoalProgress newProgress;
  const UpdateGoalProgressSuccessAction(this.newProgress);
}
