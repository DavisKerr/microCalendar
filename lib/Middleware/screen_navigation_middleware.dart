import 'package:flutter/material.dart';
import 'package:micro_calendar/Screens/activity_log_screen.dart';
import 'package:micro_calendar/Screens/create_goal_screen.dart';
import 'package:micro_calendar/Screens/sign_up_screen.dart';
import 'package:redux/redux.dart';

import '../Actions/navigation_actions.dart';
import '../Model/goal.dart';
import '../Screens/sign_in_screen.dart';
import '../State/app_state.dart';
import '../Utils/navigator_key.dart';

void navigateToLogin() async
{
  navigatorKey.currentState?.push(MaterialPageRoute(
  builder: (BuildContext context) => SignInScreen()
));
}

void navigateToGoalCreation() async
{
  navigatorKey.currentState?.push(MaterialPageRoute(
  builder: (BuildContext context) => CreateGoalScreen()
));
}

void navigateToActivityLog(Goal goal) async
{
  navigatorKey.currentState?.push(MaterialPageRoute(
  builder: (BuildContext context) => ActivityLogScreen(goal: goal)
));
}

void navigateBack() async
{
  navigatorKey.currentState?.pop();
}

void navigateToSignUp() async
{
  navigatorKey.currentState?.push(MaterialPageRoute(
  builder: (BuildContext context) => SignUpScreen()
));
}

void navigationMiddleware(
  Store<AppState> store,
  action,
  NextDispatcher next
) {
  if (action is NavigateToLogInScreenAction) {
    navigateToLogin();
    }
  else if(action is NavigateBackAction)
  {
    navigateBack();
  }
  else if(action is NavigateToActivityLogScreenAction)
  {
    navigateToActivityLog(action.goal);
  }
  else if(action is NavigateToGoalCreationScreenAction)
  {
    navigateToGoalCreation();
  }
  else if(action is NavigateToSignUpScreenAction)
  {
    navigateToSignUp();
  }

  next(action);
}

