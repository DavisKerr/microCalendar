import 'package:flutter/material.dart';
import 'package:micro_calendar/Widgets/modify_notification_popup.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:micro_calendar/Widgets/track_goal_popup.dart';
import 'package:micro_calendar/Widgets/edit_delete_goal_popup.dart';
import '../Model/goal.dart';
import '../View/view_model.dart';
import '../Widgets/confirmation_window.dart';


void startConfirmationWindow(BuildContext ctx, Goal goal, Function action) {
    showDialog(
      context: ctx, 
      builder: (BuildContext context) {
        return ConfirmationWindow(onConfirmAction: action);}
    );
  }

  void startGoalTracker(BuildContext ctx, Goal goal, 
  DateTime startDate, [double startUnits = 0, bool canDelete = false, int progressId = -1]) {
    showDialog(context: ctx,
      builder: (BuildContext context) {
        return TrackGoalPopup(
          goal: goal, 
          startDate: startDate, 
          includeDelete: canDelete,
          startUnits: startUnits,
          progressId: progressId,
        );
    });
  }

  void startGoalEditor(BuildContext ctx, Goal goal, ViewModel viewModel) {
    showDialog(context: ctx,
      builder: (BuildContext context) {
        return EditDeleteGoalPopup(goal: goal, viewModel: viewModel,);
    });
  }

    void startNotificationEditor(BuildContext ctx, Goal goal, ViewModel viewModel) {
    showDialog(context: ctx,
      builder: (BuildContext context) {
        return EditGoalNotificationPopup(goal: goal, viewModel: viewModel,);
    });
  }