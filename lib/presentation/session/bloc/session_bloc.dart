import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_prgrado/config/routes/routes.dart';
import 'package:flutter_application_prgrado/core/resources/data_state.dart';
import 'package:flutter_application_prgrado/data/models/prototype/request.dart';
import 'package:flutter_application_prgrado/domain/entities/user.dart';
import 'package:flutter_application_prgrado/domain/usecases/remove_session.dart';
import 'package:flutter_application_prgrado/domain/usecases/save_session.dart';

import 'package:flutter_application_prgrado/presentation/session/bloc/session_event.dart';
import 'package:flutter_application_prgrado/presentation/session/bloc/session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final RemoveSessionUseCase _removeSessionUseCase;
  SessionBloc(this._removeSessionUseCase) : super(SessionState()) {
    on<StartedSessionEvent>(_started);
    on<SaveSessionEvent>(_saveSession);
    on<RemoveSessionEvent>(_removeSession);
    on<ConnectedSessionEvent>(_connectedSession);
    on<LogoutSessionEvent>(logout);
  }

  void _started(StartedSessionEvent event, Emitter<SessionState> emit) {}

  void _saveSession(
    SaveSessionEvent event,
    Emitter<SessionState> emit,
  ) {
    emit(state.copyWith(user: event.user));
  }

  void _connectedSession(
    ConnectedSessionEvent event,
    Emitter<SessionState> emit,
  ) {
    if (event.connected) {
      emit(state.copyWith(statusConnection: StatusConnection.connected));
    } else {
      emit(state.copyWith(statusConnection: StatusConnection.disable));
    }
  }

  void _removeSession(
    RemoveSessionEvent event,
    Emitter<SessionState> emit,
  ) {
    emit(RemoveSessionState());
  }

  Future<void> logout(
    LogoutSessionEvent event,
    Emitter<SessionState> emit,
  ) async {
    final BuildContext buildContext = event.context;
    /*await authenticationRepository.signOut();
    sessionBloc.removerUser();*/
    final response = await _removeSessionUseCase();
    if (response is DataSuccess) {
      if (response.data!) {
        add(RemoveSessionEvent());
        Future.microtask(() {
          Navigator.pushNamedAndRemoveUntil(
              buildContext, Routes.login, (route) => false);
        });
      }
    }

    if (response is DataFailed) {
      //print(response.dioException);
    }
  }

  /*void setUser(UserEntity userData) {
    add(SaveSessionEvent(userData));
  }

  void removerUser() {
    add(const ChangeSessionSessionEvent(null));
  }*/
}
