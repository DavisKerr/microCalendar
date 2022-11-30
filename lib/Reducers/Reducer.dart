import 'dart:math';

import 'package:flutter/material.dart' as Flutter;
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:micro_calendar/Actions/account_actions.dart';
import 'package:micro_calendar/Actions/db_actions.dart';
import 'package:micro_calendar/Actions/event_response_actions.dart';
import 'package:micro_calendar/Actions/navigation_actions.dart';
import 'package:micro_calendar/Model/goal_notification.dart';
import 'package:time_machine/time_machine.dart';

import '../State/app_state.dart';
import '../Model/goal.dart';
import '../Model/goal_progress.dart';
import '../Actions/action.dart';
import '../Actions/goal_actions.dart';

/*
* Event data structure to minimize new operations. 
*/

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
  if(progress.isEmpty) {
    return 0;
  }
  else if(goal.goalQuantity <= 0) {
    return 100;
  }
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
  DeleteGoalSuccessAction action,
) {
  return previousItems.where((Goal e) => e.goalId != action.goalId);
}



Iterable<Goal> addGoal(
  AppState previousState, 
  InsertGoalSuccessAction action
) {
  Goal newGoal = Goal(
     goalName: action.goal.goalName,
    goalVerb: action.goal.goalVerb,
    goalQuantity: action.goal.goalQuantity,
    goalUnits: action.goal.goalUnits,
    goalPeriod: action.goal.goalPeriod,
    goalStartDate: action.goal.goalStartDate,
    goalEndDate: action.goal.goalEndDate,
    goalId: action.goalId,
    progressPercentage: 0.0,
  );

  return previousState.goalList + newGoal;
}

Iterable<Goal> updateGoal(
  Iterable<Goal> previousItems,
  UpdateGoalSuccessAction action
) {
  return previousItems.map((Goal e) {
    if(e.goalId == action.newGoal.goalId)
    {
      return Goal(
        goalName: action.newGoal.goalName,
        goalVerb: action.newGoal.goalVerb,
        goalQuantity: action.newGoal.goalQuantity,
        goalUnits: action.newGoal.goalUnits,
        goalPeriod: action.newGoal.goalPeriod,
        goalStartDate: action.newGoal.goalStartDate,
        goalEndDate: action.newGoal.goalEndDate,
        goalProgress: e.goalProgress,
        goalId: e.goalId,
        progressPercentage: e.progressPercentage,
        complete: action.newGoal.complete
      );
    }
    else {
      return e;
    }
  });
}

Iterable<Goal> addProgress(
  Iterable<Goal> goalList,
  InsertGoalProgressSuccessAction action
) {
  
  return goalList.map((goal) {
    if(goal.goalId == action.goalId)
    {
      Iterable<GoalProgress> newProgress = quicksort(goal.goalProgress + 
        GoalProgress(progress: action.progress.progress, dateString: action.progress.dateString, id: action.progressId, goalId: goal.goalId)
      );
      return Goal(
        goalName: goal.goalName,
        goalVerb: goal.goalVerb,
        goalQuantity: goal.goalQuantity,
        goalUnits: goal.goalUnits,
        goalPeriod: goal.goalPeriod,
        goalStartDate: goal.goalStartDate,
        goalEndDate: goal.goalEndDate,
        goalId: goal.goalId,
        goalProgress: newProgress,
        progressPercentage: calculateNewProgress(newProgress, goal),
        nextProgressId: goal.nextProgressId + 1,
        complete: goal.complete
      );
    }
    else {
      return goal;
    }
  });
}

Iterable<Goal> deleteProgress(
  Iterable<Goal> goalList,
  DeleteGoalProgressSuccessAction action
) {
  
  return goalList.map((goal) {
    if(goal.goalId == action.goalId)
    {
      Iterable<GoalProgress> newProgress = quicksort(goal.goalProgress.where((i) => i.id != action.progressId));
      return Goal(
        goalName: goal.goalName,
        goalVerb: goal.goalVerb,
        goalQuantity: goal.goalQuantity,
        goalUnits: goal.goalUnits,
        goalPeriod: goal.goalPeriod,
        goalStartDate: goal.goalStartDate,
        goalEndDate: goal.goalEndDate,
        goalId: goal.goalId,
        goalProgress: newProgress,
        progressPercentage: calculateNewProgress(newProgress, goal),
        nextProgressId: goal.nextProgressId,
        complete: goal.complete
      );
    }
    else {
      return goal;
    }
  });
}

Iterable<Goal> updateProgress(
  Iterable<Goal> goalList,
  UpdateGoalProgressSuccessAction action
) {
  
  return goalList.map((goal) {
    if(goal.goalId == action.newProgress.goalId)
    {
      Iterable<GoalProgress> newProgress = quicksort((goal.goalProgress.map((i) {
        return i.id == action.newProgress.id ? action.newProgress : i;

      })));
      return Goal(
        goalName: goal.goalName,
        goalVerb: goal.goalVerb,
        goalQuantity: goal.goalQuantity,
        goalUnits: goal.goalUnits,
        goalPeriod: goal.goalPeriod,
        goalStartDate: goal.goalStartDate,
        goalEndDate: goal.goalEndDate,
        goalId: goal.goalId,
        goalProgress: newProgress,
        progressPercentage: calculateNewProgress(newProgress, goal),
        nextProgressId: goal.nextProgressId,
        complete: goal.complete
      );
    }
    else {
      return goal;
    }
  });
}

Iterable<Goal> loadData(LoadDataSuccessAction action)
{
  return action.goals.map((goal) {
    Iterable<GoalProgress> progress = action.progress.where((e) => e.goalId == goal.goalId);
    return Goal(
        goalName: goal.goalName,
        goalVerb: goal.goalVerb,
        goalQuantity: goal.goalQuantity,
        goalUnits: goal.goalUnits,
        goalPeriod: goal.goalPeriod,
        goalStartDate: goal.goalStartDate,
        goalEndDate: goal.goalEndDate,
        goalId: goal.goalId,
        goalProgress: progress, //action.progress.where((element) => element.goalId == goal.goalId),
        progressPercentage: calculateNewProgress(progress, goal),
        nextProgressId: 7,
        complete: goal.complete
      );
  });
}

Iterable<Goal> modifyGoalListReducer(
  AppState oldAppState,
  Action action,
) {
  if(action is LoadDataSuccessAction)
  {
    return loadData(action);
    //return oldAppState.goalList;
  }
  else if(action is DeleteGoalSuccessAction) {
    return deleteGoal(oldAppState.goalList, action);
  }
  else if(action is UpdateGoalSuccessAction) {
    return updateGoal(oldAppState.goalList, action);
  }
  else if(action is InsertGoalSuccessAction) {
     return addGoal(oldAppState, action);
  }
  else if(action is InsertGoalProgressSuccessAction) {
    return addProgress(oldAppState.goalList, action);
  }
  else if(action is DeleteGoalProgressSuccessAction) {
    return deleteProgress(oldAppState.goalList, action);
  }
  else if(action is UpdateGoalProgressSuccessAction) {
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

bool modifySignInReducer(bool oldAppState, Action action)
{
  if(action is SignInSuccessAccountAction)
  {
     return true;
  }
  else if(action is SignOutAccountAction) {
    return false;
  }
  else {
    return oldAppState;
  }
}

bool modifyinitLoadingReducer(bool oldAppState, Action action)
{
  if(action is LoadDataAttemptAction)
  {
    return true;
  }
  else if(action is LoadDataSuccessAction)
  {
    return false;
  }
  else
  {
    return oldAppState;
  }
}

String modifyUsernameReducer(String username, Action action) 
{
  if(action is SignInSuccessAccountAction) {
    return action.username;
  }
  else if(action is SignOutAccountAction) {
    return "";
  }
  else {
    return username;
  }
}

GoalNotification modifyNotificationReducer(GoalNotification notification, Action action) 
{
  if(action is LoadGoalNotificationSuccessAction) {
    return action.notification;
  }
  else {
    return notification;
  }
}

double setHeight(double oldHeight,Action action) {
  if(action is SetScreenDimensions)
  {
    return action.maxHeight;
  }
  else {
    return oldHeight;
  }
}

double setWidth(double oldWidth,Action action) {
  if(action is SetScreenDimensions)
  {
    return action.maxWidth;
  }
  else {
    return oldWidth;
  }
}

double setTextScaleFactor(double oldTextScaleFactor,Action action) {
  if(action is SetScreenDimensions)
  {
    return action.textScaleFactor;
  }
  else {
    return oldTextScaleFactor;
  }
}

String modifyTokenReducer(String oldToken, Action action) {
  if(action is SignInSuccessAccountAction) {
    return action.token;
  }
  else if(action is SignInFailAccountAction) {
    return "";
  }
  else if(action is SignOutAccountAction) {
    return "";
  }
  else {
    return oldToken;
  }
  
}

bool modifySignInErrors(bool signInErrors, action) {
  if(action is SignInFailAccountAction) {
    return true;
  }
  else if(action is SignInSuccessAccountAction) {
    return false;
  }
  else {
    return signInErrors;
  }
}

String modifySignInErrorMessage(String signInErrorMessage, Action action) {
  if(action is SignInSuccessAccountAction) {
    return "";
  }
  else if(action is SignInFailAccountAction) {
    return "Incorrect username or password";
  }
  else {
    return signInErrorMessage;
  }
}

bool modifyLoadingReducer(bool oldLoading, Action action) {
  if(action is SignInAttemptAccountAction || action is RegisterAttemptAccountAction) {
    return true;
  }
  else if(action is SignInSuccessAccountAction || action is RegisterSuccessAccountAction) {
    return false;
  }
  else if(action is SignInFailAccountAction || action is RegisterFailAccountAction) {
    return false;
  }
  else {
    return oldLoading;
  }
}

bool modifyShowToastReducer(bool oldShowToast, Action action) {
  if(action is ShowToastAction) {
    return true;
  }
  else if(action is HideToastAction) {
    return false;
  }
  else {
    return oldShowToast;
  }
}

String modifyToastMessageReducer(String oldToastMessage, Action action) {
  if(action is ShowToastAction) {
    return action.message;
  }
  else if(action is HideToastAction) {
    return "";
  }
  else {
    return oldToastMessage;
  }
}

bool modifyRegisterErrors(bool registerErrors, Action action) {
  if(action is RegisterFailAccountAction) {
    return true;
  }
  else if(action is RegisterSuccessAccountAction) {
    return false;
  }
  else {
    return registerErrors;
  }
}

String modifyRegisterErrorMessage(String registerErrorMessage, action) {
  if(action is RegisterFailAccountAction) {
    return action.errorMessage;
  }
  else if(action is RegisterSuccessAccountAction) {
    return "";
  }
  else {
    return registerErrorMessage;
  }
}

AppState appStateReducer(
  AppState oldAppState,
  action
) => AppState(
  goalList: modifyGoalListReducer(oldAppState, action),
  nextGoalId: modifyGoalIdCounterReducer(oldAppState, action),
  signedIn: modifySignInReducer(oldAppState.signedIn, action),
  username: modifyUsernameReducer(oldAppState.username, action),
  initLoading: modifyinitLoadingReducer(oldAppState.initLoading, action),
  notification: modifyNotificationReducer(oldAppState.notification, action),
  maxHeight: setHeight(oldAppState.maxHeight, action),
  maxWidth: setWidth(oldAppState.maxWidth, action),
  textScaleFactor: setTextScaleFactor(oldAppState.textScaleFactor, action),
  token: modifyTokenReducer(oldAppState.token, action),
  signInErrors: modifySignInErrors(oldAppState.signInErrors, action),
  signInErrorMessage: modifySignInErrorMessage(oldAppState.signInErrorMessage, action),
  loading: modifyLoadingReducer(oldAppState.loading, action),
  showToast: modifyShowToastReducer(oldAppState.showToast, action),
  toastMessage: modifyToastMessageReducer(oldAppState.toastMessage, action),
  registerErrors: modifyRegisterErrors(oldAppState.registerErrors, action), 
  registerErrorMessage: modifyRegisterErrorMessage(oldAppState.registerErrorMessage, action)
);

















