import 'package:flutter/material.dart';

import '../Model/goal.dart';
import 'action.dart' as AppAction;

@immutable
abstract class NavigationAction extends AppAction.Action{
  const NavigationAction();
}

@immutable
class NavigateToLogInScreenAction extends NavigationAction {
  const NavigateToLogInScreenAction();
}

@immutable
class NavigateBackAction extends NavigationAction {
  const NavigateBackAction();
}

@immutable
class NavigateToGoalCreationScreenAction extends NavigationAction {
  const NavigateToGoalCreationScreenAction();
}

@immutable
class NavigateToActivityLogScreenAction extends NavigationAction {
  final Goal goal;
  const NavigateToActivityLogScreenAction(this.goal);
}

@immutable
class NavigateToSignUpScreenAction extends NavigationAction {
  const NavigateToSignUpScreenAction();
}