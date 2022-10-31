import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

@immutable
class GoalProgress {
  final double progress;
  final String dateString;
  final int id;
  final int goalId;

  const GoalProgress({required this.progress, required this.dateString, required this.id, required this.goalId});

  operator +(GoalProgress other) => this.progress + other.progress;
}