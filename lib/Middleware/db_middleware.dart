import 'package:micro_calendar/Database/db_helper.dart';
import 'package:micro_calendar/Model/goal_notification.dart';
import 'package:redux/redux.dart';

import '../Actions/db_actions.dart';
import '../Actions/notification_actions.dart';
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

Future<int> insertGoalNotification(String goalName, int goalId, String dateTime, int notificationPeriod) {
    return DBHelper.insertGoalNotification(goalName, goalId, dateTime, notificationPeriod);
}

Future<int> deleteGoalNotification(int goalId) {
  return DBHelper.deleteGoalNotification(goalId);
}

Future<List<Map<String, dynamic>>> getGoalNotifications(int goalId) {
  return DBHelper.getGoalNotifications(goalId);
}

Future<int> updateGoalNotification(int goalId, int period, String dateTime) {
    return DBHelper.updateGoalNotification(goalId, period, dateTime);
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

    getGoalNotifications(action.goalId).then((notifications) {
      print(notifications);
      deleteGoalNotification(action.goalId).then(
      (deletedRows) {
        deleteGoal(action.goalId).then((_) => store.dispatch(DeleteGoalSuccessAction(action.goalId)));
        if(deletedRows > 0) {
          deleteGoalNotification(action.goalId);
        }
      });
      for(Map<String, dynamic> notification in notifications) {
        print("Notification found");
        store.dispatch(DeleteNotificationAction(notification["goal_notification_id"]));
      }
    });
    
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
  else if(action is InsertGoalWithNotificationAttemptAction)
  {
    insertGoal(
      action.goal.goalName,
      action.goal.goalVerb, 
      action.goal.goalUnits, 
      action.goal.goalQuantity, 
      action.goal.goalPeriod,
      action.goal.goalStartDate,
      action.goal.goalEndDate,
      ).then((id) {
        store.dispatch(InsertGoalSuccessAction(id, action.goal));
        GoalNotification newGoalNotification = GoalNotification(
          notificationId: -1,
          goalName: action.goal.goalName, 
          timeAndDay: action.goalNotification.timeAndDay, 
          goalId: id, 
          period: action.goalNotification.period);
        store.dispatch(InsertGoalNotificationAttemptAction(newGoalNotification));
      });
  }
  else if(action is InsertGoalNotificationAttemptAction) {
    insertGoalNotification(action.newGoalNotification.goalName, action.newGoalNotification.goalId, action.newGoalNotification.timeAndDay, action.newGoalNotification.period).then((id) {
      store.dispatch(CreateNotificationAction(action.newGoalNotification, id));
    });
  }
  else if(action is LoadGoalNotificationAttemptAction) {
    getGoalNotifications(action.goalId).then((values) {
      GoalNotification notification = GoalNotification(
        notificationId: values.first["goal_notification_id"],
        goalName: "", 
        timeAndDay: values.first["goal_notification_datetime"], 
        goalId: values.first["goal_id"], 
        period: values.first["goal_notification_period"]);
        store.dispatch(LoadGoalNotificationSuccessAction(notification));
    });
  }
  else if(action is UpdateGoalNotificationAttemptAction)
  {
    updateGoalNotification(action.notification.goalId, action.notification.period, action.notification.timeAndDay).then((value) {
      store.dispatch(UpdateGoalNotificationSuccessAction(action.notification));
    });
  }

  next(action);
}