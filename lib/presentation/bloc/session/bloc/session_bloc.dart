import 'package:bloc/bloc.dart';
import 'package:flutter_application_prgrado/data/models/user.dart';
import 'package:flutter_application_prgrado/domain/usecases/verification_connection.dart';
import 'package:flutter_application_prgrado/presentation/bloc/session/bloc/session_event.dart';
import 'package:flutter_application_prgrado/presentation/bloc/session/bloc/session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  SessionBloc() : super(SessionState()) {
    on<StartedSessionEvent>((event, emit) => _started(event, emit));
    on<ChangeSessionSessionEvent>((event, emit) => _changeSession(event, emit));
  }

  void _started(StartedSessionEvent event, Emitter<SessionState> emit) {}

  void _changeSession(
    ChangeSessionSessionEvent event,
    Emitter<SessionState> emit,
  ) {
    emit(state.copyWith(user: event.user));
  }

  void setUser(User userData) {
    add(ChangeSessionSessionEvent(userData));
  }

  void removerUser() {
    add(const ChangeSessionSessionEvent(null));
  }
}
