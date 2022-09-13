import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './goal_progress.dart';

enum PeriodUnit {day, week, month}

@immutable
class Goal {
  final String goalName;
  final String goalVerb;
  final double goalQuantity;
  final String goalUnits;
  final PeriodUnit goalPeriod;
  final String goalStartDate; 
  final String goalEndDate; 
  final Iterable<GoalProgress>? progress;
  final Object? subGoal;
  final String? goalContext;
  final int goalId;

  const Goal({
    required this.goalName,
    required this.goalVerb,
    required this.goalQuantity,
    required this.goalUnits,
    required this.goalPeriod,
    required this.goalStartDate,
    required this.goalEndDate,
    required this.goalId,
    this.subGoal,
    this.goalContext,
    this.progress
  });

  @override 
  String toString() {
    return '';
  }
}