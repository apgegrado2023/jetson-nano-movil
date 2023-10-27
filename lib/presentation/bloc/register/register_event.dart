import 'package:flutter/cupertino.dart';

abstract class RegisterEvent {
  const RegisterEvent();
}

class StartedRegisterEvent implements RegisterEvent {
  const StartedRegisterEvent();
}

class NameChangedRegisterEvent implements RegisterEvent {
  final String name;
  const NameChangedRegisterEvent(this.name);
}

class LastNameChangedRegisterEvent implements RegisterEvent {
  final String lastName;
  const LastNameChangedRegisterEvent(this.lastName);
}

class LastNameSecondChangedRegisterEvent implements RegisterEvent {
  final String lastNameSecond;
  const LastNameSecondChangedRegisterEvent(this.lastNameSecond);
}

class PasswordChangedRegisterEvent implements RegisterEvent {
  final String password;
  const PasswordChangedRegisterEvent(this.password);
}

class LoginSubmittedRegisterEvent implements RegisterEvent {
  final BuildContext context;
  const LoginSubmittedRegisterEvent(this.context);
}
