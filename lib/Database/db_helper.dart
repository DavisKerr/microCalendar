import 'package:micro_calendar/Model/goal.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

import './db_statements.dart';

class DBHelper {

  static var uuid = Uuid();

  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    //await sql.deleteDatabase(path.join(dbPath, "goal.db"));
    return sql.openDatabase(path.join(dbPath, "goal.db"), onCreate: (db, version) async {
      for(String query in buildDB)
      {
        await db.execute(query);
      }
    }, version: 1);
  }

  // static Future<void> insert(String table, Map<String, Object> data) async {
  //   final db = await DBHelper.database();
  //   await db.insert(
  //     table, 
  //     data, 
  //     conflictAlgorithm: sql.ConflictAlgorithm.replace);

  // }

  static Future<List<Map<String, dynamic>>> getGoals(bool includeTest) async {
    final db = await DBHelper.database();
    return db.rawQuery("SELECT * FROM goal_table WHERE NOT goal_is_test_data AND NOT goal_deleted");
  }

  static Future<List<Map<String, dynamic>>> getGoalIdByUUID(String goalUuid) async {
    final db = await DBHelper.database();
    return db.rawQuery("SELECT goal_id FROM goal_table WHERE goal_uuid = '$goalUuid'");
  }

  static Future<List<Map<String, dynamic>>> getAllGoals() async {
    final db = await DBHelper.database();
    return db.rawQuery("SELECT * FROM goal_table WHERE NOT goal_is_test_data");
  }

  static Future<List<Map<String, dynamic>>> getProgress() async {
    final db = await DBHelper.database();
    
    return db.rawQuery("SELECT * FROM goal_progress_table WHERE NOT progress_is_test_data AND NOT progress_deleted");
  }

  static Future<List<Map<String, dynamic>>> getAllProgress() async {
    final db = await DBHelper.database();
    
    return db.rawQuery("SELECT * FROM goal_progress_table WHERE NOT progress_is_test_data");
  }

  static Future<int> insertProgress(double units, String dateString, int goalId, String progressUuid) async {
    final db = await DBHelper.database();
    return db.insert("goal_progress_table", {
        "progress_date" : dateString, 
        "progress_units" : units, 
        "progress_is_test_data" : 0,
        "progress_deleted" : 0,
        "goal_id" : goalId,
        "progress_uuid" : progressUuid == "" ? uuid.v4() : progressUuid
    });
  }

  static Future<int> deleteProgressById(int progressId) async {
    final db = await DBHelper.database();
    return db.update(
      "goal_progress_table",
      {
          "progress_deleted" : 1
      }
      ,where: "progress_id = $progressId"
    );
  }

    static Future<int> deleteProgressByGoalId(int goalId) async {
    final db = await DBHelper.database();
    return db.update("goal_progress_table", {"progress_deleted" : 1}, where: "goal_id = $goalId");
  }

  static Future<int> updateProgress(double units, String dateString, int progressId) async {
    final db = await DBHelper.database();
    return db.update(
      "goal_progress_table",
      {
          "progress_date" : dateString, 
          "progress_units" : units, 
      }
      ,where: "progress_id = $progressId"
    );
  }

  static Future<int> insertGoal(
    String name, String verb, String units,
    double quantity, PeriodUnit period, 
    String start, String end, String goalUuid
  ) async {
    final db = await DBHelper.database();
    return db.insert("goal_table", {
        "goal_name" : name,
        "goal_verb" : verb, 
        "goal_quantity" : quantity, 
        "goal_units" : units,
        "goal_period" : period == PeriodUnit.day ? 1 : period == PeriodUnit.week ? 2 : 3,
        "goal_start_date" : start,
        "goal_end_date" : end,
        "goal_completed" : 0,
        "goal_date_created" : DateTime.now().toString(),
        "goal_is_test_data" : 0,
        "goal_deleted" : 0,
        "goal_uuid" : goalUuid == "" ? uuid.v4() : goalUuid
    });
  }

  static Future<int> deleteGoal(int goalId) async {
    final db = await DBHelper.database();
    return db.update("goal_table", {"goal_deleted" : 1}, where: "goal_id = $goalId");
  }

  static Future<int> updateGoal(String name, String verb, String units,
    double quantity, PeriodUnit period, 
    String start, String end, int goalId, bool complete) async {
    final db = await DBHelper.database();
    return db.update(
      "goal_table",
      {
        "goal_name" : name,
        "goal_verb" : verb, 
        "goal_quantity" : quantity, 
        "goal_units" : units,
        "goal_period" : period == PeriodUnit.day ? 1 : period == PeriodUnit.week ? 2 : 3,
        "goal_start_date" : start,
        "goal_end_date" : end,
        "goal_completed" : complete ? 1 : 0,
        "goal_date_created" : DateTime.now().toString(),
        "goal_is_test_data" : 0
    },
    where: "goal_id = $goalId"
    );
  }

  static Future<int> insertGoalNotification(
    String goalName, int goalId, String dateTime, int notificationPeriod
  ) async {
    final db = await DBHelper.database();
    return db.insert("goal_notification_table", {
        "goal_notification_name" : goalName,
        "goal_notification_period" : notificationPeriod,
        "goal_notification_datetime" : dateTime, 
        "goal_id" : goalId,
    });
  }

  static Future<int> deleteGoalNotification(
    int goalId
  ) async {
    final db = await DBHelper.database();
    return db.delete("goal_notification_table", where: "goal_id = $goalId");
  }

  static Future<List<Map<String, dynamic>>> getGoalNotifications(
    int goalId
  ) async {
    final db = await DBHelper.database();
    return db.rawQuery("SELECT * FROM goal_notification_table WHERE goal_id = $goalId");
  }

  static Future<int> updateGoalNotification(
    int goalId, int period, String dateTime
  ) async {
    final db = await DBHelper.database();
    return db.update("goal_notification_table", 
      {"goal_notification_period" : period, "goal_notification_datetime" : dateTime} ,
      where: "goal_notification_id = $goalId"
    );
  }



}