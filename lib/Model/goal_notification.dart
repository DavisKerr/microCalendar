import 'package:flutter/material.dart';

@immutable
class GoalNotification {
  final int notificationId;
  final String goalName;
  final String timeAndDay;
  final int goalId;
  final int period; // 0 = day, 1 = week

  const GoalNotification({
    required this.notificationId,
    required this.goalName,
    required this.timeAndDay,
    required this.goalId,
    required this.period
  });

  const GoalNotification.empty() : goalId = -1, goalName = "", timeAndDay = "", period = 0, notificationId = -1;
}