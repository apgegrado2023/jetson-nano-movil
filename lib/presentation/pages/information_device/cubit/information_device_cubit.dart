import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_prgrado/core/resources/data_state.dart';
import 'package:flutter_application_prgrado/core/resources/http_state.dart';
import 'package:flutter_application_prgrado/data/data_sources/failures.dart';
import 'package:flutter_application_prgrado/domain/entities/information_system.dart';
import 'package:flutter_application_prgrado/domain/usecases/get_information_device.dart';
import 'package:flutter_application_prgrado/presentation/bloc/session/bloc/session_bloc.dart';
import 'package:flutter_application_prgrado/presentation/bloc/session/bloc/session_event.dart';
import 'package:retrofit/dio.dart';

part 'information_device_state.dart';

class InformationDeviceCubit extends Cubit<InformationDeviceState> {
  InformationDeviceCubit(this.sessionBloc, this._getInformationDeviceUseCase)
      : super(InformationDeviceState());

  final SessionBloc sessionBloc;
  final GetInformationDeviceUseCase _getInformationDeviceUseCase;
  bool _timerStarted = false;
  Future<void> initial() async {
    getInfoDevice();
  }

  Future<void> getInfoDevice() async {
    _timerStarted = true;
    while (_timerStarted) {
      await onGetInformationDevice();
      if (state.status == StatusInformationDevice.success) {
        sessionBloc.add(ConnectedSessionEvent(true));
      } else if (state.status == StatusInformationDevice.error) {
        sessionBloc.add(ConnectedSessionEvent(false));
      }
      print("5 segundos");
      await Future.delayed(Duration(seconds: 8));
      /*log("inicia llamado");
      final httpResponse = await _getInformationDeviceUseCase();
      if (httpResponse is DataSuccess) {
        sessionBloc.add(ConnectedSessionEvent(true));
        onChangeData(httpResponse.data!);
        print(httpResponse.data);
      } else {
        //_timerStarted = false;
        sessionBloc.add(ConnectedSessionEvent(false));
        onDisconnection();

        //continue;*/
    }
  }

  Future<void> onGetInformationDevice() async {
    emit(state.copyWith(status: StatusInformationDevice.loading));
    final httpResponse = await _getInformationDeviceUseCase();
    if (httpResponse is DataSuccess) {
      final systemInfoEntity = httpResponse.data!;
      //final dsd = Dialog.close;
      emit(
        state.copyWith(
          cpuUsage: systemInfoEntity.cpuUsage,
          memoryInfoEntity: systemInfoEntity.memoryInfo,
          memoryInfoSwapEntity: systemInfoEntity.memoryInfoSwap,
          storageInfoEntity: systemInfoEntity.storageInfo,
          temperature: systemInfoEntity.cpuTemperature,
          status: StatusInformationDevice.success,
          statusConnection: StatusConnection.connected,
        ),
      );
    } else if (httpResponse is DataFailed) {
      if (httpResponse.failure == NoInternetFailure()) {
        /* if (httpResponse.dioException == DioExceptionType.connectionError) {
          emit(state.copyWith(statusConnection: StatusConnection.disconnected));
        }*/
      } else
        emit(state.copyWith(
          status: StatusInformationDevice.error,
        ));
    }
  }

  void onChangeData(SystemInfoEntity systemInfoEntity) {
    emit(
      state.copyWith(
        cpuUsage: systemInfoEntity.cpuUsage,
        memoryInfoEntity: systemInfoEntity.memoryInfo,
        memoryInfoSwapEntity: systemInfoEntity.memoryInfoSwap,
        storageInfoEntity: systemInfoEntity.storageInfo,
        temperature: systemInfoEntity.cpuTemperature,
      ),
    );
  }

  void onDisconnection() {
    emit(state.copyWith(statusConnection: StatusConnection.disconnected));
  }

  void onChangeDialogState(DialogState dialogState) =>
      emit(state.copyWith(dialog: dialogState));

  @override
  Future<void> close() {
    print("se cierra");
    _timerStarted = false;
    return super.close();
  }
}
