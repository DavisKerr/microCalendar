import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

@immutable
class GoalProgress {
  final double progress;
  final String dateString;

  const GoalProgress({required this.progress, required this.dateString});

  operator +(GoalProgress other) => this.progress + other.progress;
}