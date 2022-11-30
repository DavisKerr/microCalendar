# Details

Date : 2022-11-24 14:22:35

Directory /Users/davis/Desktop/SeniorProject/micro_calendar/lib

Total : 64 files,  5723 codes, 153 comments, 728 blanks, all 6604 lines

[Summary](results.md) / Details / [Diff Summary](diff.md) / [Diff Details](diff-details.md)

## Files
| filename | language | code | comment | blank | total |
| :--- | :--- | ---: | ---: | ---: | ---: |
| [lib/Actions/account_actions.dart](/lib/Actions/account_actions.dart) | Dart | 41 | 0 | 11 | 52 |
| [lib/Actions/action.dart](/lib/Actions/action.dart) | Dart | 5 | 0 | 1 | 6 |
| [lib/Actions/db_actions.dart](/lib/Actions/db_actions.dart) | Dart | 132 | 0 | 28 | 160 |
| [lib/Actions/event_response_actions.dart](/lib/Actions/event_response_actions.dart) | Dart | 15 | 0 | 5 | 20 |
| [lib/Actions/goal_actions.dart](/lib/Actions/goal_actions.dart) | Dart | 56 | 0 | 17 | 73 |
| [lib/Actions/navigation_actions.dart](/lib/Actions/navigation_actions.dart) | Dart | 39 | 0 | 9 | 48 |
| [lib/Actions/notification_actions.dart](/lib/Actions/notification_actions.dart) | Dart | 23 | 0 | 6 | 29 |
| [lib/Database/create_database.sql](/lib/Database/create_database.sql) | SQL | 109 | 0 | 7 | 116 |
| [lib/Database/db_helper.dart](/lib/Database/db_helper.dart) | Dart | 136 | 8 | 23 | 167 |
| [lib/Database/db_statements.dart](/lib/Database/db_statements.dart) | Dart | 105 | 0 | 11 | 116 |
| [lib/Middleware/account_middleware.dart](/lib/Middleware/account_middleware.dart) | Dart | 75 | 9 | 13 | 97 |
| [lib/Middleware/db_middleware.dart](/lib/Middleware/db_middleware.dart) | Dart | 269 | 0 | 24 | 293 |
| [lib/Middleware/notification_middleware.dart](/lib/Middleware/notification_middleware.dart) | Dart | 22 | 0 | 6 | 28 |
| [lib/Middleware/screen_navigation_middleware.dart](/lib/Middleware/screen_navigation_middleware.dart) | Dart | 74 | 0 | 11 | 85 |
| [lib/Model/goal.dart](/lib/Model/goal.dart) | Dart | 41 | 0 | 5 | 46 |
| [lib/Model/goal_notification.dart](/lib/Model/goal_notification.dart) | Dart | 17 | 0 | 3 | 20 |
| [lib/Model/goal_progress.dart](/lib/Model/goal_progress.dart) | Dart | 11 | 0 | 3 | 14 |
| [lib/Reducers/Reducer.dart](/lib/Reducers/Reducer.dart) | Dart | 493 | 8 | 65 | 566 |
| [lib/Screens/activity_log_screen.dart](/lib/Screens/activity_log_screen.dart) | Dart | 92 | 1 | 14 | 107 |
| [lib/Screens/completed_goal_screen.dart](/lib/Screens/completed_goal_screen.dart) | Dart | 111 | 0 | 10 | 121 |
| [lib/Screens/create_goal_screen.dart](/lib/Screens/create_goal_screen.dart) | Dart | 357 | 3 | 36 | 396 |
| [lib/Screens/sign_in_screen.dart](/lib/Screens/sign_in_screen.dart) | Dart | 118 | 0 | 15 | 133 |
| [lib/Screens/sign_up_screen.dart](/lib/Screens/sign_up_screen.dart) | Dart | 155 | 0 | 14 | 169 |
| [lib/Screens/splash_screen.dart](/lib/Screens/splash_screen.dart) | Dart | 22 | 0 | 1 | 23 |
| [lib/SpawnPopups/spawn_popups.dart](/lib/SpawnPopups/spawn_popups.dart) | Dart | 41 | 0 | 6 | 47 |
| [lib/State/app_state.dart](/lib/State/app_state.dart) | Dart | 104 | 0 | 7 | 111 |
| [lib/Styles/app_themes.dart](/lib/Styles/app_themes.dart) | Dart | 40 | 0 | 7 | 47 |
| [lib/Utils/date_formatter.dart](/lib/Utils/date_formatter.dart) | Dart | 4 | 0 | 1 | 5 |
| [lib/Utils/navigator_key.dart](/lib/Utils/navigator_key.dart) | Dart | 2 | 0 | 1 | 3 |
| [lib/Utils/notification_service.dart](/lib/Utils/notification_service.dart) | Dart | 80 | 12 | 18 | 110 |
| [lib/View/view_model.dart](/lib/View/view_model.dart) | Dart | 245 | 1 | 30 | 276 |
| [lib/Widgets/ActivityLogWidgets/progress_box.dart](/lib/Widgets/ActivityLogWidgets/progress_box.dart) | Dart | 45 | 19 | 12 | 76 |
| [lib/Widgets/ActivityLogWidgets/progress_list.dart](/lib/Widgets/ActivityLogWidgets/progress_list.dart) | Dart | 32 | 0 | 3 | 35 |
| [lib/Widgets/CreateGoalFormWidgets/create_goal_footer.dart](/lib/Widgets/CreateGoalFormWidgets/create_goal_footer.dart) | Dart | 59 | 0 | 6 | 65 |
| [lib/Widgets/CreateGoalFormWidgets/create_goal_form_context.dart](/lib/Widgets/CreateGoalFormWidgets/create_goal_form_context.dart) | Dart | 93 | 0 | 11 | 104 |
| [lib/Widgets/CreateGoalFormWidgets/create_goal_form_dates.dart](/lib/Widgets/CreateGoalFormWidgets/create_goal_form_dates.dart) | Dart | 131 | 1 | 10 | 142 |
| [lib/Widgets/CreateGoalFormWidgets/create_goal_form_end.dart](/lib/Widgets/CreateGoalFormWidgets/create_goal_form_end.dart) | Dart | 96 | 0 | 7 | 103 |
| [lib/Widgets/CreateGoalFormWidgets/create_goal_form_example.dart](/lib/Widgets/CreateGoalFormWidgets/create_goal_form_example.dart) | Dart | 94 | 0 | 9 | 103 |
| [lib/Widgets/CreateGoalFormWidgets/create_goal_form_introduction.dart](/lib/Widgets/CreateGoalFormWidgets/create_goal_form_introduction.dart) | Dart | 68 | 1 | 5 | 74 |
| [lib/Widgets/CreateGoalFormWidgets/create_goal_form_measurement.dart](/lib/Widgets/CreateGoalFormWidgets/create_goal_form_measurement.dart) | Dart | 92 | 0 | 9 | 101 |
| [lib/Widgets/CreateGoalFormWidgets/create_goal_form_mindway_check.dart](/lib/Widgets/CreateGoalFormWidgets/create_goal_form_mindway_check.dart) | Dart | 75 | 0 | 6 | 81 |
| [lib/Widgets/CreateGoalFormWidgets/create_goal_form_name.dart](/lib/Widgets/CreateGoalFormWidgets/create_goal_form_name.dart) | Dart | 94 | 0 | 9 | 103 |
| [lib/Widgets/CreateGoalFormWidgets/create_goal_form_notifications.dart](/lib/Widgets/CreateGoalFormWidgets/create_goal_form_notifications.dart) | Dart | 218 | 1 | 21 | 240 |
| [lib/Widgets/CreateGoalFormWidgets/create_goal_form_period.dart](/lib/Widgets/CreateGoalFormWidgets/create_goal_form_period.dart) | Dart | 80 | 1 | 7 | 88 |
| [lib/Widgets/CreateGoalFormWidgets/create_goal_form_quantity.dart](/lib/Widgets/CreateGoalFormWidgets/create_goal_form_quantity.dart) | Dart | 92 | 0 | 9 | 101 |
| [lib/Widgets/CreateGoalFormWidgets/create_goal_form_verb.dart](/lib/Widgets/CreateGoalFormWidgets/create_goal_form_verb.dart) | Dart | 92 | 0 | 9 | 101 |
| [lib/Widgets/account_menu_button.dart](/lib/Widgets/account_menu_button.dart) | Dart | 50 | 2 | 6 | 58 |
| [lib/Widgets/add_goal_button.dart](/lib/Widgets/add_goal_button.dart) | Dart | 24 | 1 | 5 | 30 |
| [lib/Widgets/back_and_next_buttons.dart](/lib/Widgets/back_and_next_buttons.dart) | Dart | 41 | 0 | 4 | 45 |
| [lib/Widgets/confirmation_window.dart](/lib/Widgets/confirmation_window.dart) | Dart | 37 | 0 | 8 | 45 |
| [lib/Widgets/edit_delete_goal_popup.dart](/lib/Widgets/edit_delete_goal_popup.dart) | Dart | 164 | 0 | 24 | 188 |
| [lib/Widgets/goal_box.dart](/lib/Widgets/goal_box.dart) | Dart | 103 | 1 | 11 | 115 |
| [lib/Widgets/goal_screen.dart](/lib/Widgets/goal_screen.dart) | Dart | 53 | 0 | 6 | 59 |
| [lib/Widgets/horizontal_progress_bar.dart](/lib/Widgets/horizontal_progress_bar.dart) | Dart | 33 | 0 | 4 | 37 |
| [lib/Widgets/large_completed_goal_menu_button.dart](/lib/Widgets/large_completed_goal_menu_button.dart) | Dart | 100 | 0 | 13 | 113 |
| [lib/Widgets/large_goal_menu_button.dart](/lib/Widgets/large_goal_menu_button.dart) | Dart | 117 | 0 | 14 | 131 |
| [lib/Widgets/loading_indicator.dart](/lib/Widgets/loading_indicator.dart) | Dart | 39 | 0 | 4 | 43 |
| [lib/Widgets/main_app_menu_button.dart](/lib/Widgets/main_app_menu_button.dart) | Dart | 40 | 2 | 10 | 52 |
| [lib/Widgets/modify_notification_popup.dart](/lib/Widgets/modify_notification_popup.dart) | Dart | 132 | 81 | 24 | 237 |
| [lib/Widgets/number_wheel_selector.dart](/lib/Widgets/number_wheel_selector.dart) | Dart | 37 | 0 | 3 | 40 |
| [lib/Widgets/screen_tracker_indicators.dart](/lib/Widgets/screen_tracker_indicators.dart) | Dart | 34 | 0 | 5 | 39 |
| [lib/Widgets/text_popup_menu.dart](/lib/Widgets/text_popup_menu.dart) | Dart | 35 | 0 | 2 | 37 |
| [lib/Widgets/track_goal_popup.dart](/lib/Widgets/track_goal_popup.dart) | Dart | 173 | 0 | 23 | 196 |
| [lib/main.dart](/lib/main.dart) | Dart | 116 | 1 | 21 | 138 |

[Summary](results.md) / Details / [Diff Summary](diff.md) / [Diff Details](diff-details.md)