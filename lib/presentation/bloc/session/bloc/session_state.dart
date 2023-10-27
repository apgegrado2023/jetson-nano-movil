import 'package:flutter_application_prgrado/data/models/user.dart';

class SessionState {
  final User? user;

  SessionState({
    this.user,
  });

  SessionState copyWith({
    User? user,
  }) {
    return SessionState(
      user: user ?? this.user,
    );
  }
}
