import 'package:bloc/bloc.dart';
import 'package:flutter_application_prgrado/domain/entities/user.dart';
import 'package:flutter_application_prgrado/domain/usecases/save_session.dart';

import 'package:flutter_application_prgrado/presentation/bloc/session/bloc/session_event.dart';
import 'package:flutter_application_prgrado/presentation/bloc/session/bloc/session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  SessionBloc() : super(SessionState()) {
    on<StartedSessionEvent>(_started);
    on<SaveSessionEvent>(_saveSession);
    on<RemoveSessionEvent>(_removeSession);
  }

  void _started(StartedSessionEvent event, Emitter<SessionState> emit) {}

  void _saveSession(
    SaveSessionEvent event,
    Emitter<SessionState> emit,
  ) {
    emit(state.copyWith(user: event.user));
  }

  void _removeSession(
    RemoveSessionEvent event,
    Emitter<SessionState> emit,
  ) {
    emit(RemoveSessionState());
  }

  /*void setUser(UserEntity userData) {
    add(SaveSessionEvent(userData));
  }

  void removerUser() {
    add(const ChangeSessionSessionEvent(null));
  }*/
}
