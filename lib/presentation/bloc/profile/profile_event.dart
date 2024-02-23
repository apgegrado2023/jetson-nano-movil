part of 'profile_bloc.dart';

abstract class ProfileEvent {
  const ProfileEvent();
}

class StartedEvent implements ProfileEvent {
  const StartedEvent();
}

class NameChangedProfileEvent implements ProfileEvent {
  final BuildContext context;
  final String name;
  const NameChangedProfileEvent(this.name, this.context);
}

class LastNameChangedProfileEvent implements ProfileEvent {
  final String lastName;
  final BuildContext context;
  const LastNameChangedProfileEvent(this.lastName, this.context);
}

class UserNameChangedProfileEvent implements ProfileEvent {
  final String userName;
  final BuildContext context;
  const UserNameChangedProfileEvent(this.userName, this.context);
}

class PasswordChangedProfileEvent implements ProfileEvent {
  final String passwordLast;
  final String passwordNow;
  final BuildContext context;
  const PasswordChangedProfileEvent(
      this.passwordLast, this.passwordNow, this.context);
}
