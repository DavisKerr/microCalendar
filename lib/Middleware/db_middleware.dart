import 'package:micro_calendar/Database/db_helper.dart';
import 'package:redux/redux.dart';

import '../Actions/db_actions.dart';
import '../Model/goal.dart';
import '../Model/goal_progress.dart';
import '../State/app_state.dart';

Future<Iterable<GoalProgress>> loadProgress()
{
  return DBHelper.getProgress().then((entries) => entries.map((progress){
      return GoalProgress(
        progress: progress["progress_units"],
        dateString: progress["progress_date"], id: progress["progress_id"], goalId: progress["goal_id"]);
  }));
}

Future<List<Goal>> loadGoals() async
{
  return DBHelper.getGoals(true).then((goals) => goals.map((goal) {
    
    int temp = 0;
    print(goal);
    
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
    );
  }).toList());
}

Future<int> insertProgress(int goalId, GoalProgress progress) {
  return DBHelper.insertProgress(progress.progress, progress.dateString, goalId);
}

Future<int> deleteProgress(int progressId) {
  return DBHelper.deleteProgress(progressId);
}

Future<int> updateProgress(double units, String dateString, int progressId) {
  return DBHelper.updateProgress(units, dateString, progressId);
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
    deleteProgress(action.progressId).then((id) => store.dispatch(DeleteGoalProgressSuccessAction(action.goalId, id)));
  }
  else if( action is UpdateGoalProgressAttemptAction)
  {
    print("Updating");
    updateProgress(action.newProgress.progress, action.newProgress.dateString, action.newProgress.id).then(
      (val) => store.dispatch(UpdateGoalProgressSuccessAction(action.newProgress))
    );
  }

  next(action);
}