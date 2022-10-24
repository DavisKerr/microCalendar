import 'dart:math';

import 'package:flutter/material.dart' as Flutter;
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:time_machine/time_machine.dart';

import '../State/app_state.dart';
import '../Model/goal.dart';
import '../Model/goal_progress.dart';
import '../Actions/action.dart';
import '../Actions/goal_actions.dart';

extension AddRemoveItemSorted<T> on Iterable<T> {
  Iterable<T> operator +(T other) {
    return followedBy([other]);
  }

  Iterable<T> operator -(T other) => where((element) => element != other);
}

Iterable<GoalProgress> quicksort(Iterable<GoalProgress> l)
{
  if(l.isEmpty)
  {
    return [];
  }
  else
  {
    Iterable<GoalProgress> h = [l.first];
    Iterable<GoalProgress> before = quicksort(
      l.where(
        (i) => DateTime.parse(i.dateString).isBefore(DateTime.parse(h.first.dateString)) 
        || 
        (DateTime.parse(i.dateString).isAtSameMomentAs(DateTime.parse(h.first.dateString)) && h.first.id != i.id)
      )
    );

    Iterable<GoalProgress> after = quicksort(
      l.where((i) => DateTime.parse(i.dateString).isAfter(
        DateTime.parse(h.first.dateString))));
      return after.followedBy(h).followedBy(before);
  }
}

int getNumCompletePeriods(DateTime start, DateTime end, PeriodUnit period)
{
  if(period == PeriodUnit.day)
  {
    return end.difference(start).inDays;
  }
  else if(period == PeriodUnit.week)
  {
    return  (end.difference(start).inDays / 7).round();
  }
  else 
  {
    return LocalDate.dateTime(end).periodSince(LocalDate.dateTime(start)).months;
  }
}

int getNextPeriod(DateTime start, DateTime event, PeriodUnit period)
{
  
  if(period == PeriodUnit.day)
  {
    return event.difference(start).inDays;
  }
  else if(period == PeriodUnit.week)
  {
     return (event.difference(start).inDays / 7).round();
  }
  // else 
  // {
  //   return Jiffy(current).add(months: 1).dateTime;
  // }
  else return 0;
}

double calculateNewProgress(Iterable<GoalProgress> progress, Goal goal)
{
  DateTime start = Flutter.DateUtils.dateOnly(DateTime.parse(goal.goalStartDate));
  DateTime end = Flutter.DateUtils.dateOnly(DateTime.parse(goal.goalEndDate));
  int numPeriods = getNumCompletePeriods(start, end, goal.goalPeriod);
  double total = numPeriods * goal.goalQuantity;
  int currentPeriod = -1;
  double currentSum = 0;
  double finalTotal = 0;
  for(GoalProgress item in progress)
  {
    DateTime event = DateTime.parse(item.dateString);
    int newPeriod = getNextPeriod(start, event, goal.goalPeriod);
    if(newPeriod > numPeriods || newPeriod < 0)
    {
      continue;
    }

    if(currentPeriod != newPeriod)
    {
      finalTotal += min(currentSum, goal.goalQuantity);
      currentPeriod = newPeriod;
      currentSum = item.progress;
    }
    else 
    {
      currentSum += item.progress;
    }
  }
  finalTotal += min(currentSum, goal.goalQuantity);
  return finalTotal / total;
}


Iterable<Goal> deleteGoal(
  Iterable<Goal> previousItems,
  DeleteGoalAction action,
) {
  return previousItems.where((Goal e) => e.goalId != action.goal.goalId);
}



Iterable<Goal> addGoal(
  AppState previousState, 
  AddGoalAction action
) {
  print("Working...");
  Goal newGoal = Goal(
     goalName: action.goal.goalName,
    goalVerb: action.goal.goalVerb,
    goalQuantity: action.goal.goalQuantity,
    goalUnits: action.goal.goalUnits,
    goalPeriod: action.goal.goalPeriod,
    goalStartDate: action.goal.goalStartDate,
    goalEndDate: action.goal.goalEndDate,
    goalId: previousState.nextGoalId,
    progressPercentage: 0.0,
  );

  return previousState.goalList + newGoal;
}

Iterable<Goal> editGoal(
  Iterable<Goal> previousItems,
  ModifyGoalAction action
) {
  return previousItems.map((Goal e) {
    if(e.goalId == action.goal.goalId)
    {
      return Goal(
        goalName: action.goal.goalName,
        goalVerb: action.goal.goalVerb,
        goalQuantity: action.goal.goalQuantity,
        goalUnits: action.goal.goalUnits,
        goalPeriod: action.goal.goalPeriod,
        goalStartDate: e.goalStartDate,
        goalEndDate: action.goal.goalEndDate,
        goalId: e.goalId,
        progressPercentage: e.progressPercentage,
      );
    }
    else {
      return e;
    }
  });
}

Iterable<Goal> addProgress(
  Iterable<Goal> goalList,
  AddGoalProgressAction action
) {
  
  return goalList.map((goal) {
    if(goal.goalId == action.goal.goalId)
    {
      Iterable<GoalProgress> newProgress = quicksort(goal.goalProgress + 
        GoalProgress(progress: action.progress.progress, dateString: action.progress.dateString, id: goal.nextProgressId)
      );
      return Goal(
        goalName: goal.goalName,
        goalVerb: goal.goalVerb,
        goalQuantity: goal.goalQuantity,
        goalUnits: goal.goalUnits,
        goalPeriod: goal.goalPeriod,
        goalStartDate: goal.goalStartDate,
        goalEndDate: action.goal.goalEndDate,
        goalId: goal.goalId,
        goalProgress: newProgress,
        progressPercentage: calculateNewProgress(newProgress, goal),
        nextProgressId: goal.nextProgressId + 1,
      );
    }
    else {
      return goal;
    }
  });
}

Iterable<Goal> deleteProgress(
  Iterable<Goal> goalList,
  DeleteGoalProgressAction action
) {
  
  return goalList.map((goal) {
    if(goal.goalId == action.goal.goalId)
    {
      Iterable<GoalProgress> newProgress = quicksort(goal.goalProgress.where((i) => i.id != action.progress.id));
      return Goal(
        goalName: goal.goalName,
        goalVerb: goal.goalVerb,
        goalQuantity: goal.goalQuantity,
        goalUnits: goal.goalUnits,
        goalPeriod: goal.goalPeriod,
        goalStartDate: goal.goalStartDate,
        goalEndDate: action.goal.goalEndDate,
        goalId: goal.goalId,
        goalProgress: newProgress,
        progressPercentage: calculateNewProgress(newProgress, goal),
        nextProgressId: goal.nextProgressId,
      );
    }
    else {
      return goal;
    }
  });
}

Iterable<Goal> updateProgress(
  Iterable<Goal> goalList,
  UpdateGoalProgressAction action
) {
  
  return goalList.map((goal) {
    if(goal.goalId == action.goal.goalId)
    {
      Iterable<GoalProgress> newProgress = quicksort((goal.goalProgress.map((i) {
        return i.id == action.progress.id ? action.progress : i;

      })));
      return Goal(
        goalName: goal.goalName,
        goalVerb: goal.goalVerb,
        goalQuantity: goal.goalQuantity,
        goalUnits: goal.goalUnits,
        goalPeriod: goal.goalPeriod,
        goalStartDate: goal.goalStartDate,
        goalEndDate: action.goal.goalEndDate,
        goalId: goal.goalId,
        goalProgress: newProgress,
        progressPercentage: calculateNewProgress(newProgress, goal),
        nextProgressId: goal.nextProgressId,
      );
    }
    else {
      return goal;
    }
  });
}


Iterable<Goal> modifyGoalListReducer(
  AppState oldAppState,
  Action action,
) {
  
  if(action is DeleteGoalAction) {
    return deleteGoal(oldAppState.goalList, action);
  }
  else if(action is ModifyGoalAction) {
    return editGoal(oldAppState.goalList, action);
  }
  else if(action is AddGoalAction) {
     return addGoal(oldAppState, action);
  }
  else if(action is AddGoalProgressAction) {
    return addProgress(oldAppState.goalList, action);
  }
  else if(action is DeleteGoalProgressAction) {
    return deleteProgress(oldAppState.goalList, action);
  }
  else if(action is UpdateGoalProgressAction) {
    return updateProgress(oldAppState.goalList, action);
  }
  else {
    return oldAppState.goalList;
  }
}


int modifyGoalIdCounterReducer(
  AppState oldAppState,
  Action action,
) {
  if(action is AddGoalAction)
  {
    return oldAppState.nextGoalId + 1;
  }
  else 
  {
    return oldAppState.nextGoalId; 
  }
}

AppState appStateReducer(
  AppState oldAppState,
  action
) => AppState(
  goalList: modifyGoalListReducer(oldAppState, action),
  nextGoalId: modifyGoalIdCounterReducer(oldAppState, action),
);

