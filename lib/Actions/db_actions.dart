import 'package:flutter/material.dart';
import 'package:micro_calendar/Model/goal_notification.dart';
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

@immutable
class InsertGoalAttemptAction extends DBAction {
  final Goal goal;
  const InsertGoalAttemptAction(this.goal);
}

@immutable
class InsertGoalSuccessAction extends DBAction {
  final int goalId;
  final Goal goal;
  const InsertGoalSuccessAction(this.goalId, this.goal);
}

@immutable
class InsertGoalWithNotificationAttemptAction extends DBAction {
  final Goal goal;
  final GoalNotification goalNotification;
  const InsertGoalWithNotificationAttemptAction(this.goal, this.goalNotification);
}

@immutable
class DeleteGoalAttemptAction extends DBAction {
  final int goalId;
  const DeleteGoalAttemptAction(this.goalId);
}

@immutable
class DeleteGoalSuccessAction extends DBAction {
  final int goalId;
  const DeleteGoalSuccessAction(this.goalId);
}

@immutable
class UpdateGoalAttemptAction extends DBAction {
  final Goal newGoal;
  const UpdateGoalAttemptAction(this.newGoal);
}

@immutable
class UpdateGoalSuccessAction extends DBAction {
  final Goal newGoal;
  const UpdateGoalSuccessAction(this.newGoal);
}

@immutable
class InsertGoalNotificationAttemptAction extends DBAction {
  final GoalNotification newGoalNotification;
  const InsertGoalNotificationAttemptAction(this.newGoalNotification);
}

@immutable
class InsertGoalNotificationSuccessAction extends DBAction {
  final GoalNotification newGoalNotification;
  final int goalId;
  const InsertGoalNotificationSuccessAction(this.newGoalNotification, this.goalId);
}

@immutable
class LoadGoalNotificationAttemptAction extends DBAction {
  final int goalId;
  const LoadGoalNotificationAttemptAction(this.goalId);
}

@immutable
class LoadGoalNotificationSuccessAction extends DBAction {
  final GoalNotification notification;
  const LoadGoalNotificationSuccessAction(this.notification);
}

@immutable 
class UpdateGoalNotificationAttemptAction extends DBAction {
  final GoalNotification notification;
  const UpdateGoalNotificationAttemptAction(this.notification);
}

@immutable 
class UpdateGoalNotificationSuccessAction extends DBAction {
  final GoalNotification notification;
  const UpdateGoalNotificationSuccessAction(this.notification);
}


