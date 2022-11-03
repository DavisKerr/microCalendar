import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:micro_calendar/Model/goal_notification.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  //NotificationService a singleton object
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  static const channelId = '123';

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings(
        requestSoundPermission: true,
        requestBadgePermission: true,
        requestAlertPermission: true,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: initializationSettingsIOS);

    tz.initializeTimeZones();

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,);
  }

  AndroidNotificationDetails _androidNotificationDetails =
      AndroidNotificationDetails(
      'channel ID',
      'channel name',
      playSound: true,
      priority: Priority.high,
      importance: Importance.high,
  );


  // Future<void> showNotifications() async {
  //   await flutterLocalNotificationsPlugin.show(
  //     0,
  //     "Notification Title",
  //     "This is the Notification Body!",
  //     NotificationDetails(android: _androidNotificationDetails),
  //   );
  // }

  Future<void> scheduleNotification(
    GoalNotification newNotification,
    int notificationId
  ) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        notificationId,
        "Time to work on your goal!",
        "It's time to work on your goal: ${newNotification.goalName} with ID ${newNotification.goalId}",
        tz.TZDateTime.parse(tz.local,newNotification.timeAndDay),
        //tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        NotificationDetails(android: _androidNotificationDetails),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: newNotification.period == 0 ? DateTimeComponents.time : DateTimeComponents.dayOfWeekAndTime    
    );
  }

  Future<void> replaceNotification(
    GoalNotification newNotification,
  ) async {
    await cancelNotifications(newNotification.notificationId);
    await flutterLocalNotificationsPlugin.zonedSchedule(
        newNotification.notificationId,
        "Time to work on your goal!",
        "It's time to work on your goal: ${newNotification.goalName}",
        tz.TZDateTime.parse(tz.local,newNotification.timeAndDay),
        //tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        NotificationDetails(android: _androidNotificationDetails),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: newNotification.period == 0 ? DateTimeComponents.time : DateTimeComponents.dayOfWeekAndTime    
    );
  }

  Future<void> cancelNotifications(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}

Future selectNotification(String payload) async {
  //handle your logic here
}