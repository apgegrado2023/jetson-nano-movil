import 'package:flutter/material.dart';

abstract class LoginEvent {
  const LoginEvent();
}

class EmailChangedLoginEvent implements LoginEvent {
  final String emailString;
  const EmailChangedLoginEvent(this.emailString);
}

class PasswordChangedLoginEvent implements LoginEvent {
  final String passwordString;
  const PasswordChangedLoginEvent(this.passwordString);
}

class LoginSubmittedLoginEvent implements LoginEvent {
  final BuildContext context;
  const LoginSubmittedLoginEvent(this.context);
}
