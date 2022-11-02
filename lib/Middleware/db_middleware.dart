import 'package:micro_calendar/Database/db_helper.dart';
import 'package:redux/redux.dart';

import '../Actions/db_actions.dart';
import '../Model/goal.dart';
import '../Model/goal_progress.dart';
import '../State/app_state.dart';

Future<Iterable<GoalProgress>> loadProgress()
{
  return DBHelper.getProgress().then((entries) => entries.map((progress) {
      return GoalProgress(
        progress: progress["progress_units"],
        dateString: progress["progress_date"], id: progress["progress_id"], goalId: progress["goal_id"]);
  }));
}

Future<List<Goal>> loadGoals() async
{
  return DBHelper.getGoals(true).then((goals) => goals.map((goal) {
    
    int temp = 0;
    // print(goal);
    
    return Goal(
      goalName: goal["goal_name"],
      goalVerb: goal["goal_verb"],
      goalQuantity: goal["goal_quantity"],
      goalUnits: goal["goal_units"],
      goalPeriod: goal["goal_period"] == 1 ? PeriodUnit.day : goal["period"] == 2 ? PeriodUnit.week : PeriodUnit.month,
      goalStartDate: goal["goal_start_date"],
      goalEndDate: goal["goal_end_date"],
      goalId: goal["goal_id"],
      goalProgress: const [],
      progressPercentage: 0,
      nextProgressId: 0,
      complete: goal["goal_completed"] == 1 ? true : false
    );
  }).toList());
}

Future<int> insertProgress(int goalId, GoalProgress progress) {
  return DBHelper.insertProgress(progress.progress, progress.dateString, goalId);
}

Future<int> deleteProgressById(int progressId) {
  return DBHelper.deleteProgressById(progressId);
}

Future<int> updateProgress(double units, String dateString, int progressId) {
  return DBHelper.updateProgress(units, dateString, progressId);
}

Future<int> insertGoal(String name, String verb, String units,
  double quantity, PeriodUnit period, 
  String start, String end) {
    return DBHelper.insertGoal(name, verb, units, quantity, period, start, end);
}

Future<int> updateGoal(String name, String verb, String units,
  double quantity, PeriodUnit period, 
  String start, String end, int goalId, bool complete) {
    return DBHelper.updateGoal(name, verb, units, quantity, period, start, end, goalId, complete);
}

Future<int> deleteGoal(int goalId) {
  return DBHelper.deleteGoal(goalId).then((_) => DBHelper.deleteProgressByGoalId(goalId));
}

void dbMiddleware(
  Store<AppState> store,
  action,
  NextDispatcher next
) {
  if (action is LoadDataAttemptAction) {
    
    loadGoals().then((goals) => loadProgress().then((progress) => store.dispatch(LoadDataSuccessAction(goals, progress))).catchError((e) {
      print(e);
    }));
  }
  else if(action is InsertGoalProgressAttemptAction)
  {
    print("Inserting");
    insertProgress(action.goal.goalId, action.progress).then((id) => store.dispatch(InsertGoalProgressSuccessAction(action.goal.goalId, action.progress, id)));
  }
  else if(action is DeleteGoalProgressAttemptAction)
  {
    print("Deleting");
    deleteProgressById(action.progressId).then((id) => store.dispatch(DeleteGoalProgressSuccessAction(action.goalId, id)));
  }
  else if( action is UpdateGoalProgressAttemptAction)
  {
    print("Updating");
    updateProgress(action.newProgress.progress, action.newProgress.dateString, action.newProgress.id).then(
      (val) => store.dispatch(UpdateGoalProgressSuccessAction(action.newProgress))
    );
  }
  else if( action is InsertGoalAttemptAction)
  {
    print("Inserting goal");
    insertGoal(
      action.goal.goalName, 
      action.goal.goalVerb, 
      action.goal.goalUnits, 
      action.goal.goalQuantity, 
      action.goal.goalPeriod,
      action.goal.goalStartDate,
      action.goal.goalEndDate,
      ).then((id) => store.dispatch(InsertGoalSuccessAction(id, action.goal)));
  }
  else if(action is DeleteGoalAttemptAction) {
    print("deleting from db");
    deleteGoal(action.goalId).then((_) => store.dispatch(DeleteGoalSuccessAction(action.goalId)));
  }
  else if(action is UpdateGoalAttemptAction) {
    print("updating from db");
    updateGoal(
      action.newGoal.goalName, 
      action.newGoal.goalVerb, 
      action.newGoal.goalUnits, 
      action.newGoal.goalQuantity, 
      action.newGoal.goalPeriod,
      action.newGoal.goalStartDate,
      action.newGoal.goalEndDate,
      action.newGoal.goalId,
      action.newGoal.complete
      ).then((_) => store.dispatch(UpdateGoalSuccessAction(action.newGoal)));
  }

  next(action);
}