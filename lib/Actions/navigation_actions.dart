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

@immutable
class NavigateToCompletedGoalScreenAction extends NavigationAction {
  const NavigateToCompletedGoalScreenAction();
}

@immutable 
class SetScreenDimensions extends NavigationAction {
  final double maxHeight;
  final double maxWidth;
  final double textScaleFactor;
  const SetScreenDimensions(this.maxHeight, this.maxWidth, this.textScaleFactor);
}