import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:micro_calendar/Widgets/track_goal_popup.dart';
import 'package:micro_calendar/Widgets/edit_delete_goal_popup.dart';
import '../Model/goal.dart';
import '../Widgets/confirmation_window.dart';


void startConfirmationWindow(BuildContext ctx, Store store, Goal goal, Function action) {
    showDialog(
      context: ctx, 
      builder: (BuildContext context) {
        return ConfirmationWindow(onConfirmAction: action);}
    );
  }