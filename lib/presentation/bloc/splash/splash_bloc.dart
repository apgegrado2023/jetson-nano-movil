import 'dart:developer';

import 'package:flutter_application_prgrado/domain/repository/session_repository.dart';
import 'package:flutter_application_prgrado/presentation/bloc/session/bloc/session_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/routes/routes.dart';
import '../../../domain/usecases/connection.dart';
import '../../../domain/usecases/verification_connection.dart';
import '../session/bloc/session_bloc.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final SessionRepository _session;
  final VerificationConnectionUseCase verificationConnectionUseCase;
  final ConnectionUseCase connectionUseCase;
  final SessionBloc sessionBloc;
  SplashBloc(
    this.sessionBloc,
    this.verificationConnectionUseCase,
    this.connectionUseCase,
    this._session,
  ) : super(SplashState()) {
    on<ChangeRoute>(onChangeRoute);
    on<InitialEvent>(initialEvent);
    //add(InitialEvent());
  }

  Future<void> initialEvent(
    InitialEvent event,
    Emitter<SplashState> emit,
  ) async {
    print("se llama");
    final isConnectedServer = await verificationConnectionUseCase();

    emit(state.copyWith(
      connectionStateServer: ConnectionStateServer.loading,
    ));
    print(isConnectedServer);

    if (!isConnectedServer) {
      final isConnected = await connectionUseCase();

      if (!isConnected) {
        emit(SplashState(connectionStateServer: ConnectionStateServer.failed));
        log("no hay servidor");
        return;
      } else {
        emit(state.copyWith(
          connectionStateServer: ConnectionStateServer.connected,
        ));
        log("si hay servidor");
      }

      String routeName;

      final user = await _session.getToSession();

      if (user == null) {
        routeName = Routes.login;
      } else {
        routeName = Routes.home;
        sessionBloc.add(ChangeSessionSessionEvent(user));
      }
      add(ChangeRoute(routeName));
    }
  }

  void onChangeRoute(ChangeRoute event, Emitter<SplashState> emit) {
    print("comida");
    emit(state.copyWith(route: event.route));
  }
}
