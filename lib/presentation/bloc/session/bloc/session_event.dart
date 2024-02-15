import 'package:flutter_application_prgrado/domain/entities/user.dart';

abstract class SessionEvent {
  const SessionEvent();
}

class StartedSessionEvent extends SessionEvent {
  const StartedSessionEvent() : super();
}

class SaveSessionEvent extends SessionEvent {
  final UserEntity user;
  const SaveSessionEvent(this.user) : super();
}

class RemoveSessionEvent extends SessionEvent {
  const RemoveSessionEvent();
}
