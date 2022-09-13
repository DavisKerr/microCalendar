import '../State/app_state.dart';
import '../Model/goal.dart';
import '../Model/goal_progress.dart';
import '../Actions/action.dart';
import '../Actions/goal_actions.dart';



extension AddRemoveItemSorted<T> on Iterable<T> {
  Iterable<T> operator +(T other) {
    return  followedBy([other]);
  }

  Iterable<T> operator -(T other) => where((element) => element != other);
}

Iterable<Goal> deleteGoal(
  Iterable<Goal> previousItems,
  DeleteGoalAction action,
) {
  return previousItems.where((Goal e) => e.goalId != action.goal.goalId);
}

Iterable<Goal> updateGoalProgress(
  Iterable<Goal> previousItems,
  AddGoalProgressAction action,
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
        goalStartDate: action.goal.goalStartDate,
        goalEndDate: action.goal.goalEndDate,
        goalDuration: action.goal.goalDuration, 
        progress: action.goal.progress! + action.newProgress,
        goalId: action.goal.goalId,
      );
    }
    else
    {
      return e;
    }
  });
}

Iterable<Goal> modifyGoalListReducer(
  AppState oldAppState,
  Action action,
) {
  if(action is AddGoalProgressAction) {
    return updateGoalProgress(oldAppState.goalList, action);
  }
  else if(action is DeleteGoalAction){
    return deleteGoal(oldAppState.goalList, action);
  }
  else {
    return oldAppState.goalList;
  }
}

AppState appStateReducer(
  AppState oldAppState,
  action
) => AppState(
  goalList: modifyGoalListReducer(oldAppState, action)
);