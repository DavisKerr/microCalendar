import 'package:micro_calendar/Actions/account_actions.dart';
import 'package:micro_calendar/Actions/db_actions.dart';
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


  ViewModel(
    this.goalList,
    this.notification,
    this.nextGoalId, 
    this.signedIn,
    this.username,
    this.initLoading,
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
      store.dispatch(InsertGoalAttemptAction(newGoal));
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
        InsertGoalProgressAttemptAction(goal, newProgress)
      //AddGoalProgressAction(goal, newProgress)
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
  
    return ViewModel(
      store.state.goalList,
      store.state.notification,
      store.state.nextGoalId,
      store.state.signedIn,
      store.state.username,
      store.state.initLoading,
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
    );
  }
}