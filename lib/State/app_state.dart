import 'dart:ui';
import '../Model/goal.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

@immutable
class AppState {
  final Iterable<Goal> goalList;

  const AppState({
    required this.goalList
  });

  const AppState.empty() 
    : goalList = const <Goal>[];

  const AppState.test()
    : goalList = const <Goal>[
      Goal(
        goalName: "Goal Name",
        goalVerb: "Verb",
        goalQuantity: 10,
        goalUnits: "Units",
        goalPeriod: PeriodUnit.day,
        goalStartDate: "2022-04-20 00:00:00",
        goalEndDate: "2022-12-15 23:59:99.99",
        goalDuration: Duration(days: 31), 
      )
    ];
}