import 'package:micro_calendar/Actions/account_actions.dart';
import 'package:micro_calendar/Actions/db_actions.dart';
import 'package:micro_calendar/Actions/navigation_actions.dart';
import 'package:micro_calendar/Model/goal.dart';
import 'package:redux/redux.dart';
import '../Actions/goal_actions.dart';
import '../Model/goal_progress.dart';
import '../State/app_state.dart';
 
class ViewModel{
  // AppState Properties
  Iterable<Goal> goalList;
  int nextGoalId;
  bool signedIn;
  String username;
  bool initLoading;

  final Function (Goal newGoal) editGoal;
  final Function (Goal toDelete) deleteGoal;
  final Function (Goal newGoal) createGoal;
  final Function (GoalProgress newProgress) updateProgress;
  final Function (int progressId, int goalId) deleteProgress;
  final Function (Goal goal, GoalProgress newProgress) createProgress;
  final Function (String username, String password) signInAttempt;
  final Function () navigateToLoginScreen;
  final Function () navigateBack;
  final Function () navigateToGoalCreationScreen;
  final Function (Goal goal) navigateToActivityLogScreen;
  final Function () navigateToSignUpScreen;
  final Function () loadData;

  ViewModel(
    this.goalList,
    this.nextGoalId, 
    this.signedIn,
    this.username,
    this.initLoading,
    this.editGoal,
    this.deleteGoal,
    this.createGoal,
    this.updateProgress,
    this.deleteProgress,
    this.createProgress,
    this.signInAttempt,
    this.navigateToLoginScreen,
    this.navigateBack,
    this.navigateToGoalCreationScreen,
    this.navigateToActivityLogScreen,
    this.navigateToSignUpScreen,
    this.loadData,
  );
 
  factory ViewModel.create(Store<AppState> store){
    _editGoal(Goal newGoal) {
      store.dispatch(
      ModifyGoalAction(newGoal)
    );
    }

    _deleteGoal(Goal toDelete) {
      store.dispatch(
      DeleteGoalAction(toDelete)
    );
    }

    _createGoal(Goal newGoal) {
      store.dispatch(AddGoalAction(newGoal));
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

    _loadData() {
      store.dispatch(
        LoadDataAttemptAction()
      );
    }
  
    return ViewModel(
      store.state.goalList,
      store.state.nextGoalId,
      store.state.signedIn,
      store.state.username,
      store.state.initLoading,
      _editGoal, 
      _deleteGoal,
      _createGoal,
      _updateProgress,
      _deleteProgress,
      _createProgress,
      _signInAttempt,
      _navigateToLogInScreen,
      _navigateBack,
      _navigateToGoalCreationScreen,
      _navigateToActivityLogScreen,
      _navigateToSIgnUpScreen,
      _loadData,
    );
  }
}