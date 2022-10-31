import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

import './db_statements.dart';

class DBHelper {

  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    //await sql.deleteDatabase(path.join(dbPath, "goal.db"));
    return sql.openDatabase(path.join(dbPath, "goal.db"), onCreate: (db, version) async {
      for(String query in buildDB)
      {
        await db.execute(query);
      }
      //print(await db.rawQuery("SELECT * FROM goal_table"));
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
    return db.rawQuery("SELECT * FROM goal_table");
  }

  static Future<List<Map<String, dynamic>>> getProgress() async {
    final db = await DBHelper.database();
    
    return db.rawQuery("SELECT * FROM goal_progress_table");
  }

  static Future<List<Map<String, dynamic>>> getPeriod(String period) async {
    final db = await DBHelper.database();
    return db.query("goal_period_table", where: "goal_period_name = $period");
  }

  static Future<int> insertProgress(double units, String dateString, int goalId) async {
    final db = await DBHelper.database();
    return db.insert("goal_progress_table", {
        "progress_date" : dateString, 
        "progress_units" : units, 
        "progress_is_test_data" : 0,
        "goal_id" : goalId
    });
  }

  static Future<int> deleteProgress(int progressId) async {
    final db = await DBHelper.database();
    return db.delete("goal_progress_table", where: "progress_id = $progressId");
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

}