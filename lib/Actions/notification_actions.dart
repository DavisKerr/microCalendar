import 'package:flutter/material.dart';
import 'package:micro_calendar/Model/goal_notification.dart';

import 'action.dart' as AppAction;


@immutable
abstract class NotificationAction extends AppAction.Action{
  const NotificationAction();
}

@immutable
class CreateNotificationAction extends NotificationAction {
  final GoalNotification newGoalNotification;
  final notificationId;
  const CreateNotificationAction(this.newGoalNotification, this.notificationId);
}

@immutable
class DeleteNotificationAction extends NotificationAction {
  final int notificationId;
  const DeleteNotificationAction(this.notificationId);
}

@immutable
class UpdateNotificationAction extends NotificationAction {
  final GoalNotification newGoalNotification;
  const UpdateNotificationAction(this.newGoalNotification);
}