///
/// Class: Account Action
/// These child classes of AccountAction act as signals for when a process needs to be performed and 
/// have data sent to it. 
///
///
import 'package:flutter/material.dart';

import 'action.dart' as AppAction;

/// The parent class for AccountAction
@immutable
abstract class AccountAction extends AppAction.Action {

  const AccountAction();
}

/// Action for attempting to sign in, and contains a username and password.
@immutable
class SignInAttemptAccountAction extends AccountAction{
  final String username;
  final String password;

  const SignInAttemptAccountAction(this.username, this.password);
}

/// Action for signaling a sign in attempt was successful, and contains a username 
/// and a JWT
@immutable
class SignInSuccessAccountAction extends AccountAction{
  final String username;
  final String token;
  const SignInSuccessAccountAction(this.username, this.token);
}

/// Action for signaling that a sign in attempt failed
@immutable
class SignInFailAccountAction extends AccountAction{
  const SignInFailAccountAction();
}

/// Action for signaling that a user should be logged out
@immutable 
class SignOutAccountAction extends AccountAction {
  const SignOutAccountAction();
}

// Action for attempting to register a new account. Contains a username and password. 
@immutable 
class RegisterAttemptAccountAction extends AccountAction {
  final String username;
  final String password;
  const RegisterAttemptAccountAction(this.username, this.password);
}

/// Action for signaling that an account was successfully created
@immutable 
class RegisterSuccessAccountAction extends AccountAction {
  const RegisterSuccessAccountAction();
}

// Action for signaling that creating an account failed, and contains an error message
@immutable 
class RegisterFailAccountAction extends AccountAction {
  final String errorMessage;
  const RegisterFailAccountAction(this.errorMessage);
}