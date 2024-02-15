import 'package:flutter_application_prgrado/domain/entities/user.dart';

enum StatusConnection { connected, failed, disable }

class SessionState {
  final UserEntity? user;
  final StatusConnection? statusConnection;

  SessionState({this.user, this.statusConnection});

  SessionState copyWith({
    UserEntity? user,
    StatusConnection? statusConnection,
  }) {
    return SessionState(
      user: user ?? this.user,
      statusConnection: statusConnection ?? this.statusConnection,
    );
  }
}

class RemoveSessionState extends SessionState {}
