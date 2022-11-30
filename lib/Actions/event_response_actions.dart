import 'package:flutter/material.dart';

import 'action.dart' as AppAction;

@immutable
class EventResponseAction extends AppAction.Action {
  
  const EventResponseAction();
}

@immutable
class ShowToastAction extends EventResponseAction {
  final String message;
  const ShowToastAction(this.message);
}

@immutable
class HideToastAction extends EventResponseAction {
  const HideToastAction();
}