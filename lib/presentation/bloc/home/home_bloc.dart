import 'package:flutter/material.dart';
import 'package:flutter_application_prgrado/domain/repository/session_repository.dart';
import 'package:flutter_application_prgrado/domain/repository/user_repository.dart';
import 'package:flutter_application_prgrado/presentation/bloc/home/home_event.dart';
import 'package:flutter_application_prgrado/presentation/bloc/home/home_state.dart';
import 'package:flutter_application_prgrado/presentation/bloc/session/bloc/session_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final SessionBloc sessionBloc;
  final UserRepository userRepository;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final SessionRepository _session;
  HomeBloc(
    this.sessionBloc,
    this.userRepository,
    this._session,
  ) : super(const HomeState()) {
    on<IndexChangedHomeEvent>((event, emit) => _onIndexChanged(event, emit));

    on<InitHomeEvent>((event, emit) => _init(event, emit));
  }

  void _init(
    InitHomeEvent event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(index: 0));
  }

  void _onIndexChanged(
    IndexChangedHomeEvent event,
    Emitter<HomeState> emit,
  ) {
    /*if (event.index != 0) {
      sl<PrototypeRepository>().dispose();
      sl<PrototypeRepository>().stopTimer();
      print("se para");
    }*/

    emit(state.copyWith(
      index: event.index,
    ));
  }
}
