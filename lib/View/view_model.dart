import 'package:micro_calendar/Model/goal.dart';
import 'package:redux/redux.dart';
import '../Actions/action.dart';
import '../Actions/goal_actions.dart';
import '../Model/goal_progress.dart';
import '../State/app_state.dart';
 
class ViewModel{
  // AppState Properties
  Iterable<Goal> goalList;
  int nextGoalId;
  bool signedIn;
  String username;

  final Function (Goal newGoal) editGoal;
  final Function (Goal toDelete) deleteGoal;
  final Function (Goal newGoal) createGoal;
  final Function (Goal goal, GoalProgress newProgress) editProgress;
  final Function (Goal goal, GoalProgress toDelete) deleteProgress;
  final Function (Goal goal, GoalProgress newProgress) createProgress;

  ViewModel(
    this.goalList,
    this.nextGoalId, 
    this.signedIn,
    this.username,
    this.editGoal,
    this.deleteGoal,
    this.createGoal,
    this.editProgress,
    this.deleteProgress,
    this.createProgress,
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

    _editProgress(Goal goal, GoalProgress newProgress) {
      store.dispatch(
        UpdateGoalProgressAction(goal, newProgress)
      );
    }

    _deleteProgress(Goal goal, GoalProgress toDelete) {
      store.dispatch(
        DeleteGoalProgressAction(goal, toDelete)
      );
    }

    _createProgress(Goal goal, GoalProgress newProgress) {
      store.dispatch(
      AddGoalProgressAction(goal, newProgress)
      );
    }
  
    return ViewModel(
      store.state.goalList,
      store.state.nextGoalId,
      store.state.signedIn,
      store.state.username,
      _editGoal, 
      _deleteGoal,
      _createGoal,
      _editProgress,
      _deleteProgress,
      _createProgress,
    );
  }
}