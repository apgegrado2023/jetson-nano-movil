import 'package:flutter/material.dart';
import 'package:flutter_application_prgrado/core/resources/data_state.dart';
import 'package:flutter_application_prgrado/domain/repository/user_repository.dart';
import 'package:flutter_application_prgrado/domain/usecases/check_connection.dart';
import 'package:flutter_application_prgrado/presentation/pages/home/BLOC/home_event.dart';
import 'package:flutter_application_prgrado/presentation/pages/home/BLOC/home_state.dart';
import 'package:flutter_application_prgrado/presentation/pages/home/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UserRepository userRepository;
  final CheckConnectionUseCase _checkConnectionUseCase;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  HomeBloc(
    this.userRepository,
    this._checkConnectionUseCase,
  ) : super(const HomeState()) {
    on<IndexChangedHomeEvent>(_onIndexChanged);
    on<InitHomeEvent>(_init);
    on<CheckConnectionEvent>(_checkConnection);
  }

  void _init(
    InitHomeEvent event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(index: 0));
  }

  Future<void> _checkConnection(
    CheckConnectionEvent event,
    Emitter<HomeState> emit,
  ) async {
    final response = await _checkConnectionUseCase(false);
    if (response is DataSuccess) {
      print(response.data);
      showServerStatusDialog(event.context, true);
    } else {
      showServerStatusDialog(event.context, false);
    }
  }

  void showServerStatusDialog(BuildContext context, bool isConnected) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ServerStatusDialog(isConnected: isConnected);
      },
    );
  }

  void _onIndexChanged(
    IndexChangedHomeEvent event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(
      index: event.index,
    ));
  }
}
