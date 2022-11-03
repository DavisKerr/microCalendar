import 'package:micro_calendar/Actions/db_actions.dart';
import 'package:micro_calendar/Actions/notification_actions.dart';
import 'package:redux/redux.dart';

import '../State/app_state.dart';
import "../Utils/notification_service.dart";


NotificationService notificationService = NotificationService();

void notificationMiddleware(
  Store<AppState> store,
  action,
  NextDispatcher next
) {
  if (action is CreateNotificationAction) {
    
    notificationService.scheduleNotification(action.newGoalNotification, action.notificationId);
  }
  else if(action is DeleteNotificationAction) {
    print("Canceled Notification");
    notificationService.cancelNotifications(action.notificationId);
  }
  else if(action is UpdateGoalNotificationSuccessAction) {
    print("Replacing notification");
    notificationService.replaceNotification(action.notification);
  }
  
  next(action);
}