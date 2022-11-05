import 'dart:ui';

import 'package:micro_calendar/Model/goal_notification.dart';

import '../Model/goal.dart';
import '../Model/goal_progress.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

@immutable
class AppState {
  final Iterable<Goal> goalList;
  final GoalNotification notification;
  final int nextGoalId;
  final bool signedIn;
  final String username;
  final bool initLoading;
  final double maxHeight;
  final double maxWidth;
  final double textScaleFactor;

  const AppState({
    required this.goalList,
    this.nextGoalId = 0,
    this.signedIn = false,
    this.username = "",
    this.initLoading = false,
    this.notification = const GoalNotification.empty(),
    this.maxHeight = 0,
    this.maxWidth = 0,
    this.textScaleFactor = 0,
  });

  const AppState.empty() 
    : goalList =  const <Goal>[], 
    nextGoalId = 0, 
    signedIn = false, 
    username = '', 
    initLoading = false, 
    notification = const GoalNotification.empty(),
    maxHeight = 0,
    maxWidth = 0,
    textScaleFactor = 0;

  const AppState.test()
    : goalList = const <Goal>[
      Goal(
        goalName: "Goal Name",
        goalVerb: "Verb",
        goalQuantity: 10,
        goalUnits: "Units",
        goalPeriod: PeriodUnit.day,
        goalStartDate: "2022-04-20 00:00:00",
        goalEndDate: "2022-12-15 00:00:00",
        goalId: 0,
        progressPercentage: 0.0,
      ), 
      Goal(
        goalName: "Goal Name",
        goalVerb: "Verb",
        goalQuantity: 10,
        goalUnits: "Units",
        goalPeriod: PeriodUnit.day,
        goalStartDate: "2022-04-20 00:00:00",
        goalEndDate: "2022-12-15 00:00:00",
        goalId: 1,
        progressPercentage: 0.0,
      )
    ], 
    nextGoalId = 2,
    signedIn = false,
    username = "",
    initLoading = false,
    notification = const GoalNotification.empty(),
    maxHeight = 0,
    maxWidth = 0,
    textScaleFactor = 0;    
}