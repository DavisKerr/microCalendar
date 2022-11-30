/// Class: ApiAction
/// Contains actions for sending and recieving data from the backend API 

import 'package:flutter/material.dart';

import 'action.dart' as AppAction;

/// Action for sending an API request, contains a JWT for accessing the data. 
@immutable
class ApiAction extends AppAction.Action {
  final String token;
  const ApiAction(this.token);
}

/// Action for attempting to sync data with the api.
@immutable 
class SyncApiAttemptAction extends ApiAction {
  const SyncApiAttemptAction(String token) : super(token);
}