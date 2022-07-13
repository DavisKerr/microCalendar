import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum PeriodUnit {day, week, month}

@immutable 
class Goal {
  final String goalName;
  final String goalVerb;
  final String goalUnits;
  final PeriodUnit goalPeriod;
  final Duration goalDuration;
  final DateTime goalStartDate;
  final DateTime? goalEndDate;
  final Object? subGoal;
  final String? goalContext;

  const Goal({
    required this.goalName,
    required this.goalVerb,
    required this.goalUnits,
    required this.goalPeriod,
    required this.goalDuration,
    required this.goalStartDate,
    this.goalEndDate,
    this.subGoal,
    this.goalContext
  });
}