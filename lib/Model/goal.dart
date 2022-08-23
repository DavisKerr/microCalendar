import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum PeriodUnit {day, week, month}

@immutable
class Goal {
  final String goalName;
  final String goalVerb;
  final int goalQuantity;
  final String goalUnits;
  final PeriodUnit goalPeriod;
  final Duration goalDuration;
  final String goalStartDate; // Change Back to DateTime
  final String goalEndDate; // Change Back to DateTime
  final Object? subGoal;
  final String? goalContext;
  final int? progress;

  const Goal({
    required this.goalName,
    required this.goalVerb,
    required this.goalQuantity,
    required this.goalUnits,
    required this.goalPeriod,
    required this.goalDuration,
    required this.goalStartDate,
    required this.goalEndDate,
    this.subGoal,
    this.goalContext,
    this.progress
  });

  @override 
  String toString() {
    return '';
  }
}