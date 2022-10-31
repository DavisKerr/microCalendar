import 'package:flutter/material.dart';

import 'action.dart' as AppAction;

@immutable
abstract class AccountAction extends AppAction.Action {
  final String username;

  const AccountAction(this.username,);
}

@immutable
class SignInAttemptAccountAction extends AccountAction{
  final String password;

  const SignInAttemptAccountAction(String username, this.password) : super(username);
}

@immutable
class SignInSuccessAccountAction extends AccountAction{

  const SignInSuccessAccountAction(String username) : super(username);
}