DROP TABLE IF EXISTS goal_table;

CREATE TABLE goal_table(
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
);

INSERT INTO goal_table(
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
);

DROP TABLE IF EXISTS goal_progress_table;

CREATE TABLE goal_progress_table(
    progress_id INTEGER PRIMARY KEY,
    goal_id INTEGER NOT NULL,
    progress_date VARCHAR(40),
    progress_units REAL NOT NULL,
    progress_is_test_data BOOLEAN NOT NULL,
    FOREIGN KEY (goal_id)
       REFERENCES goal_table (goal_id)
);

INSERT INTO goal_progress_table(
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
    1,
    DATETIME('2022-11-1 00:00:00'),
    1,
    1
),
(
    2,
    DATETIME('2022-10-28 00:00:00'),
    30,
    1
),
(
    2,
    DATETIME('2022-11-1 00:00:00'),
    30,
    1
),
(
    2,
    DATETIME('2022-11-3 00:00:00'),
    20,
    1
);

CREATE TABLE goal_notification_table (
    goal_notification_id INTEGER PRIMARY KEY,
    goal_notification_period INTEGER NOT NULL,
    goal_notification_datetime VARCHAR(20),
    goal_id INTEGER NOT NULL,
    FOREIGN KEY (goal_id)
       REFERENCES goal_table (goal_id)
);
