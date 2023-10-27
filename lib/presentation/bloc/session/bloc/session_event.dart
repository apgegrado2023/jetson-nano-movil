import 'package:equatable/equatable.dart';
import 'package:flutter_application_prgrado/data/models/user.dart';

abstract class SessionEvent extends Equatable {
  const SessionEvent();
}

class StartedSessionEvent extends SessionEvent {
  const StartedSessionEvent() : super();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ChangeSessionSessionEvent extends SessionEvent {
  final User? user;
  const ChangeSessionSessionEvent(this.user) : super();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
