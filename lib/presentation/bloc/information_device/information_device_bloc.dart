import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_application_prgrado/core/resources/data_state.dart';
import 'package:flutter_application_prgrado/domain/entities/information_system.dart';
import 'package:flutter_application_prgrado/domain/usecases/get_information_device.dart';
import 'package:flutter_application_prgrado/presentation/bloc/session/bloc/session_bloc.dart';
import 'package:flutter_application_prgrado/presentation/bloc/session/bloc/session_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
part 'information_device_event.dart';
part 'information_device_state.dart';

class InformationDeviceBloc
    extends Bloc<InformationDeviceEvent, InformationDeviceState> {
  final SessionBloc sessionBloc;
  final GetInformationDeviceUseCase _getInformationDeviceUseCase;
  bool _timerStarted = false;

  InformationDeviceBloc(this._getInformationDeviceUseCase, this.sessionBloc)
      : super(InformationDeviceInitial()) {
    on<InitialEvent>(init);
    on<ChangeData>(onChangeData);
    on<DisconnectionEvent>(onDisconnection);
  }

  Future<void> init(
    InitialEvent event,
    Emitter<InformationDeviceState> emit,
  ) async {
    getInfoDevice();
  }

  Future<void> getInfoDevice() async {
    _timerStarted = true;
    while (_timerStarted) {
      print("inicia llamdo");
      final httpResponse = await _getInformationDeviceUseCase();
      if (httpResponse is DataSuccess) {
        sessionBloc.add(ConnectedSessionEvent(true));
        add(ChangeData(httpResponse.data!));
      } else {
        //_timerStarted = false;
        sessionBloc.add(ConnectedSessionEvent(false));
        add(DisconnectionEvent());
        //continue;
      }
      print("5 segundos");
      await Future.delayed(Duration(seconds: 8));
    }
  }

  void onChangeData(
    ChangeData event_,
    Emitter<InformationDeviceState> emit,
  ) {
    final event = event_.systemInfoEntity;
    emit(
      InformationDeviceDone(
        cpuUsage: event.cpuUsage!,
        memoryInfoEntity: event.memoryInfo!,
        memoryInfoSwapEntity: event.memoryInfoSwap!,
        storageInfoEntity: event.storageInfo!,
        temperature: event.cpuTemperature!,
      ),
    );
  }

  void onDisconnection(
    DisconnectionEvent event_,
    Emitter<InformationDeviceState> emit,
  ) {
    emit(InformationDeviceDisconnection());
  }

  @override
  Future<void> close() {
    print("se cierra");
    _timerStarted = false;
    return super.close();
  }
}
