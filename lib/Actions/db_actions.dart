/// Class: DBAction
/// Contains app actions for signaling database operations.

import 'package:flutter/material.dart';
import 'package:micro_calendar/Model/goal_notification.dart';
import 'package:micro_calendar/Model/goal_progress.dart';

import '../Model/goal.dart';
import 'action.dart' as AppAction;

/// Class for signaling Database actions
@immutable
abstract class DBAction extends AppAction.Action{
  const DBAction();
}


/// Action for attempting to load data.
@immutable
class LoadDataAttemptAction extends DBAction {
  const LoadDataAttemptAction();
}

/// Action for signaling that data was successfully loaded, contains a list of goals and progress events.
@immutable
class LoadDataSuccessAction extends DBAction {
  final List<Goal> goals;
  final Iterable<GoalProgress> progress;
  const LoadDataSuccessAction(this.goals, this.progress);
}

/// Action for attempting to insert a new progress event
@immutable
class InsertGoalProgressAttemptAction extends DBAction {
  final int goalId;
  final GoalProgress progress;
  final String progressUuid;
  const InsertGoalProgressAttemptAction(this.goalId, this.progress, this.progressUuid);
}

// Action for inserting data from JSON
@immutable 
class InsertDataFromJSONAction extends DBAction {
  final List<dynamic> json;
  const InsertDataFromJSONAction(this.json);
}

/// Action for signaling a progress event was succussfully added
@immutable
class InsertGoalProgressSuccessAction extends DBAction {
  final int goalId;
  final int progressId;
  final GoalProgress progress;
  const InsertGoalProgressSuccessAction(this.goalId, this.progress, this.progressId);
}

/// Action for attempting to delete a progress event
@immutable
class DeleteGoalProgressAttemptAction extends DBAction {
  final int goalId;
  final int progressId;
  const DeleteGoalProgressAttemptAction(this.goalId, this.progressId);
}

/// Action for signaling a progress event was successfully deleted
@immutable
class DeleteGoalProgressSuccessAction extends DBAction {
  final int goalId;
  final int progressId;
  const DeleteGoalProgressSuccessAction(this.goalId, this.progressId);
}

/// Action for updating a progress event
@immutable
class UpdateGoalProgressAttemptAction extends DBAction {
  final GoalProgress newProgress;
  const UpdateGoalProgressAttemptAction(this.newProgress);
}

/// Action for signaling a goal was successfully updated
@immutable
class UpdateGoalProgressSuccessAction extends DBAction {
  final GoalProgress newProgress;
  const UpdateGoalProgressSuccessAction(this.newProgress);
}

/// Action for attempting to insert a new goal
@immutable
class InsertGoalAttemptAction extends DBAction {
  final Goal goal;
  final String goalUuid;
  const InsertGoalAttemptAction(this.goal, this.goalUuid);
}

/// Action for signaling a goal was successfully inserted
@immutable
class InsertGoalSuccessAction extends DBAction {
  final int goalId;
  final Goal goal;
  const InsertGoalSuccessAction(this.goalId, this.goal);
}

/// Action for attempting to add a new goal with an included notification
@immutable
class InsertGoalWithNotificationAttemptAction extends DBAction {
  final Goal goal;
  final GoalNotification goalNotification;
  const InsertGoalWithNotificationAttemptAction(this.goal, this.goalNotification);
}

/// Action for attempting to delete a goal
@immutable
class DeleteGoalAttemptAction extends DBAction {
  final int goalId;
  const DeleteGoalAttemptAction(this.goalId);
}

/// Action for signaling a goal was successfully deleted
@immutable
class DeleteGoalSuccessAction extends DBAction {
  final int goalId;
  const DeleteGoalSuccessAction(this.goalId);
}

/// Action for attempting to update a goal
@immutable
class UpdateGoalAttemptAction extends DBAction {
  final Goal newGoal;
  const UpdateGoalAttemptAction(this.newGoal);
}

/// Action for signaling that a goal was successfully updated
@immutable
class UpdateGoalSuccessAction extends DBAction {
  final Goal newGoal;
  const UpdateGoalSuccessAction(this.newGoal);
}

/// Action for attempting to add a new goal notification
@immutable
class InsertGoalNotificationAttemptAction extends DBAction {
  final GoalNotification newGoalNotification;
  const InsertGoalNotificationAttemptAction(this.newGoalNotification);
}

/// Action for signaling a new notification was successfully added
@immutable
class InsertGoalNotificationSuccessAction extends DBAction {
  final GoalNotification newGoalNotification;
  final int goalId;
  const InsertGoalNotificationSuccessAction(this.newGoalNotification, this.goalId);
}

/// Action for attempting to load a notification
@immutable
class LoadGoalNotificationAttemptAction extends DBAction {
  final int goalId;
  const LoadGoalNotificationAttemptAction(this.goalId);
}

/// Action for signaling a notification was loaded successfully 
@immutable
class LoadGoalNotificationSuccessAction extends DBAction {
  final GoalNotification notification;
  const LoadGoalNotificationSuccessAction(this.notification);
}

/// Action for attempting to update a goal notification
@immutable 
class UpdateGoalNotificationAttemptAction extends DBAction {
  final GoalNotification notification;
  const UpdateGoalNotificationAttemptAction(this.notification);
}

/// Action for signaling a goal notification was updated successfully
@immutable 
class UpdateGoalNotificationSuccessAction extends DBAction {
  final GoalNotification notification;
  const UpdateGoalNotificationSuccessAction(this.notification);
}

/// Action for attempting to delete a goal notification 
@immutable 
class DeleteGoalNotificationAttemptAction extends DBAction {
  final GoalNotification notification;
  const DeleteGoalNotificationAttemptAction(this.notification);
}

/// Action for signaling a notification has been deleted
@immutable 
class DeleteGoalNotificationSuccessAction extends DBAction {
  final GoalNotification notification;
  const DeleteGoalNotificationSuccessAction(this.notification);
}


