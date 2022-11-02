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
  final Object? subGoal;
  final String? goalContext;
  final int goalId;
  final Iterable<GoalProgress> goalProgress;
  final double progressPercentage;
  final int nextProgressId;
  final bool complete;

  const Goal({
    required this.goalName,
    required this.goalVerb,
    required this.goalQuantity,
    required this.goalUnits,
    required this.goalPeriod,
    required this.goalStartDate,
    required this.goalEndDate,
    required this.goalId,
    required this.progressPercentage,
    this.goalProgress = const Iterable.empty(),
    this.nextProgressId = 0,
    this.complete = false,
    this.subGoal,
    this.goalContext,
  });

  @override 
  String toString() {
    return '';
  }
}