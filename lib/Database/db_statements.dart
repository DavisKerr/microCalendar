
const String dropGoalTable = "DROP TABLE IF EXISTS goal_table";
const String dropGoalProgressTable = "DROP TABLE IF EXISTS goal_progress_table";
const String dropGoalNotificationTable = "DROP TABLE IF EXISTS goal_notification_table";

const String createGoalTable = '''CREATE TABLE goal_table(
  goal_id INTEGER PRIMARY KEY,
  goal_name VARCHAR(60) NOT NULL,
  goal_verb VARCHAR(60) NOT NULL,
  goal_quantity REAL NOT NULL,
  goal_units VARCHAR(60) NOT NULL,
  goal_period INTEGER NOT NULL,
  goal_start_date VARCHAR(40) NOT NULL,
  goal_end_date VARCHAR(40) NOT NULL,
  goal_completed BOOLEAN NOT NULL,
  goal_date_created DATETIME NOT NULL,
  goal_is_test_data BOOLEAN NOT NULL
) ''';

const String createGoalProgressTable = '''CREATE TABLE goal_progress_table(
          progress_id INTEGER PRIMARY KEY,
          goal_id INTEGER NOT NULL,
          progress_date VARCHAR(40),
          progress_units REAL NOT NULL,
          progress_is_test_data BOOLEAN NOT NULL,
          FOREIGN KEY (goal_id)
            REFERENCES goal_table (goal_id)
      )''';


const insertIntoGoalTable = ''' INSERT INTO goal_table(
          goal_name, 
          goal_verb,
          goal_quantity,
          goal_units,
          goal_period,
          goal_start_date,
          goal_end_date,
          goal_completed,
          goal_date_created,
          goal_is_test_data
      )
      VALUES 
      ("Exercise", 
      "Run", 
      1.0, 
      "Mile", 
      1, 
      "2022-04-20 00:00:00",
      "2022-12-15 00:00:00",
      0,
      DATETIME('now'),
      1
      ),
      ("Read", 
      "Read", 
      30.0, 
      "Page", 
      1, 
      "2022-04-20 00:00:00",
      "2022-12-15 00:00:00",
      0,
      DATETIME('now'),
      1
      )''';

const insertIntoGoalProgressTable = '''INSERT INTO goal_progress_table(
          goal_id,
          progress_date, 
          progress_units, 
          progress_is_test_data
      )
      VALUES (
          1,
          DATETIME('now'),
          1,
          1
      ),
      (
          1,
          DATETIME('2022-10-29 00:00:00'),
          1,
          1
      ),
      (
          2,
          DATETIME('2022-10-29 00:00:00'),
          30,
          1
      )
       ''';

const createGoalNotificationTable = ''' CREATE TABLE goal_notification_table (
    goal_notification_id INTEGER PRIMARY KEY,
    goal_notification_name VARCHAR(60),
    goal_notification_period INTEGER NOT NULL,
    goal_notification_datetime VARCHAR(20),
    goal_id INTEGER NOT NULL,
    FOREIGN KEY (goal_id)
       REFERENCES goal_table (goal_id)
) ''';

const List<String> buildDB = [dropGoalTable, dropGoalProgressTable, dropGoalNotificationTable, createGoalTable,
createGoalProgressTable, createGoalNotificationTable, insertIntoGoalTable, insertIntoGoalProgressTable];


