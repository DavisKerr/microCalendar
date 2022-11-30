import 'package:flutter/material.dart';
import 'package:micro_calendar/Actions/account_actions.dart';
import 'package:micro_calendar/Actions/api_actions.dart';
import 'package:micro_calendar/Actions/db_actions.dart';
import 'package:micro_calendar/Actions/event_response_actions.dart';
import 'package:micro_calendar/Actions/navigation_actions.dart';
import 'package:micro_calendar/Model/goal.dart';
import 'package:micro_calendar/Model/goal_notification.dart';
import 'package:redux/redux.dart';
import '../Actions/goal_actions.dart';
import '../Model/goal_progress.dart';
import '../State/app_state.dart';
 
class ViewModel{
  // AppState Properties
  Iterable<Goal> goalList;
  GoalNotification notification;
  int nextGoalId;
  bool signedIn;
  String username;
  bool initLoading;
  double maxHeight;
  double maxWidth;
  double textScaleFactor;
  String token;
  bool signInErrors;
  String signInErrorMessage;
  bool loading;
  bool showToast;
  String toastMessage;
  bool registerErrors;
  String registerErrorMessage;

  final Function (Goal newGoal) updateGoal;
  final Function (Goal toDelete) deleteGoal;
  final Function (Goal goal) completeGoal;  
  final Function (Goal goal) unCompleteGoal;
  final Function (Goal newGoal) createGoal;
  final Function (Goal newGoal, GoalNotification newNotification) createGoalWithNotifications;
  final Function (GoalProgress newProgress) updateProgress;
  final Function (int progressId, int goalId) deleteProgress;
  final Function (Goal goal, GoalProgress newProgress) createProgress;
  final Function (String username, String password) signInAttempt;
  final Function () navigateToLoginScreen;
  final Function () navigateBack;
  final Function () navigateToGoalCreationScreen;
  final Function (Goal goal) navigateToActivityLogScreen;
  final Function () navigateToSignUpScreen;
  final Function () navigateToCompletedGoalScreen;
  final Function () loadData;
  final Function (GoalNotification notification) updateGoalNotification;
  final Function (GoalNotification notification) insertGoalNotification;
  final Function (GoalNotification notification) deleteGoalNotification;
  final Function (int goalId) loadGoalNotification;
  final Function (double height, double width, double textScaleFactor) setScreenDimensions;
  final Function () logout;
  final Function (String username, String password) register;
  final Function () hideToast;
  final Function (String token) sync;


  ViewModel(
    this.goalList,
    this.notification,
    this.nextGoalId, 
    this.signedIn,
    this.username,
    this.initLoading,
    this.maxHeight,
    this.maxWidth,
    this.textScaleFactor,
    this.token,
    this.signInErrors,
    this.signInErrorMessage,
    this.loading,
    this.showToast,
    this.toastMessage,
    this.registerErrors,
    this.registerErrorMessage,
    this.updateGoal,
    this.deleteGoal,
    this.completeGoal,
    this.unCompleteGoal,
    this.createGoal,
    this.createGoalWithNotifications,
    this.updateProgress,
    this.deleteProgress,
    this.createProgress,
    this.signInAttempt,
    this.navigateToLoginScreen,
    this.navigateBack,
    this.navigateToGoalCreationScreen,
    this.navigateToActivityLogScreen,
    this.navigateToSignUpScreen,
    this.navigateToCompletedGoalScreen,
    this.loadData,
    this.updateGoalNotification,
    this.insertGoalNotification,
    this.deleteGoalNotification,
    this.loadGoalNotification,
    this.setScreenDimensions,
    this.logout,
    this.register,
    this.hideToast,
    this.sync,
  );
 
  factory ViewModel.create(Store<AppState> store){
    _updateGoal(Goal newGoal) {
      store.dispatch(
      UpdateGoalAttemptAction(newGoal)
    );
    }

    _deleteGoal(Goal toDelete) {
      store.dispatch(
      DeleteGoalAttemptAction(toDelete.goalId)
    );
    }

    _createGoal(Goal newGoal) {
      store.dispatch(InsertGoalAttemptAction(newGoal, ""));
    }

    _createGoalWithNotification(Goal newGoal, GoalNotification newNotification) {
      store.dispatch(InsertGoalWithNotificationAttemptAction(newGoal, newNotification));
    }

    _updateProgress(GoalProgress newProgress) {
      store.dispatch(
        UpdateGoalProgressAttemptAction(newProgress)
      );
    }

    _deleteProgress(int progressId, int goalId) {
      store.dispatch(
        DeleteGoalProgressAttemptAction(goalId, progressId)
      );
    }

    _createProgress(Goal goal, GoalProgress newProgress) {
      store.dispatch(
        InsertGoalProgressAttemptAction(goal.goalId, newProgress, "")
      );
    }

    _signInAttempt(String username, String password) {
      store.dispatch(
      SignInAttemptAccountAction(username, password)
      );
    }

    _navigateToLogInScreen() {
      store.dispatch(
        NavigateToLogInScreenAction()
      );
    }

    _navigateBack() {
      store.dispatch(
        NavigateBackAction()
      );
    }

    _navigateToGoalCreationScreen() {
      store.dispatch(
        NavigateToGoalCreationScreenAction()
      );
    }

    _navigateToActivityLogScreen(Goal goal) {
      store.dispatch(
        NavigateToActivityLogScreenAction(goal)
      );
    }

    _navigateToSIgnUpScreen() {
      store.dispatch(
        NavigateToSignUpScreenAction()
      );
    }
    _navigateToCompletedGoalScreen() {
      store.dispatch(NavigateToCompletedGoalScreenAction());
    }

    _loadData() {
      store.dispatch(
        LoadDataAttemptAction()
      );
    }

    _updateGoalNotification(GoalNotification notification) {
      store.dispatch(UpdateGoalNotificationAttemptAction(notification));
    }

    _insertGoalNotification(GoalNotification notification) {
      store.dispatch(InsertGoalNotificationAttemptAction(notification));
    }

    _deleteGoalNotification(GoalNotification notification) {
      store.dispatch(DeleteGoalNotificationAttemptAction(notification));
    }

    _loadGoalNotification(int goalId) {
      store.dispatch(LoadGoalNotificationAttemptAction(goalId));
    }

    _completeGoal(Goal goal) {
      store.dispatch(CompleteGoalAttemptAction(goal));
    }
    
    _unCompleteGoal(Goal goal) {
      store.dispatch(UnCompleteGoalAttemptAction(goal));
    }

    _setScreenDimensions(double height, double width, double textScaleFactor) {
      print("Setting Dimensions");

      store.dispatch(SetScreenDimensions(height, width, textScaleFactor));
    }

    _logout() {
      store.dispatch(SignOutAccountAction());
    }

    _register(String username, String password) {
      store.dispatch(RegisterAttemptAccountAction(username, password));
    }

    _hideToast() {
      store.dispatch(HideToastAction());
    }

    _sync(String token) {
      store.dispatch(SyncApiAttemptAction(token));
    }
  
    return ViewModel(
      store.state.goalList,
      store.state.notification,
      store.state.nextGoalId,
      store.state.signedIn,
      store.state.username,
      store.state.initLoading,
      store.state.maxHeight,
      store.state.maxWidth,
      store.state.textScaleFactor,
      store.state.token,
      store.state.signInErrors,
      store.state.signInErrorMessage,
      store.state.loading,
      store.state.showToast,
      store.state.toastMessage,
      store.state.registerErrors,
      store.state.registerErrorMessage,
      _updateGoal, 
      _deleteGoal,
      _completeGoal,
      _unCompleteGoal,
      _createGoal,
      _createGoalWithNotification,
      _updateProgress,
      _deleteProgress,
      _createProgress,
      _signInAttempt,
      _navigateToLogInScreen,
      _navigateBack,
      _navigateToGoalCreationScreen,
      _navigateToActivityLogScreen,
      _navigateToSIgnUpScreen,
      _navigateToCompletedGoalScreen,
      _loadData,
      _updateGoalNotification,
      _insertGoalNotification,
      _deleteGoalNotification,
      _loadGoalNotification,
      _setScreenDimensions,
      _logout,
      _register,
      _hideToast,
      _sync,
    );
  }
}