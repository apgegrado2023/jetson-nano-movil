import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_application_prgrado/core/resources/data_state.dart';
import 'package:flutter_application_prgrado/data/data_sources/failures.dart';
import 'package:flutter_application_prgrado/domain/entities/information_system.dart';
import 'package:flutter_application_prgrado/domain/usecases/get_information_device.dart';

part 'information_device_state.dart';

class InformationDeviceCubit extends Cubit<InformationDeviceState> {
  InformationDeviceCubit(
    this._getInformationDeviceUseCase,
  ) : super(InformationDeviceState());

  final GetInformationDeviceUseCase _getInformationDeviceUseCase;
  bool _timerStarted = false;

  Future<void> initial() async {
    getInfoDevice();
  }

  Future<void> getInfoDevice() async {
    _timerStarted = true;
    while (_timerStarted) {
      await onGetInformationDevice();
      await Future.delayed(Duration(seconds: 8));
    }
  }

  Future<void> onGetInformationDevice() async {
    emit(state.copyWith(status: StatusInformationDevice.loading));
    final httpResponse = await _getInformationDeviceUseCase();
    if (httpResponse is DataSuccess) {
      final systemInfoEntity = httpResponse.data!;

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
      if (httpResponse.failure is NoInternetFailure) {
        if (state.statusConnection == StatusConnection.disconnected) return;
        emit(state.copyWith(
          statusConnection: StatusConnection.disconnected,
          status: StatusInformationDevice.error,
        ));
      } else {
        emit(state.copyWith(
          status: StatusInformationDevice.error,
        ));
      }
    }
  }

  void onChangeDialogState(DialogState dialogState) =>
      emit(state.copyWith(dialog: dialogState));

  @override
  Future<void> close() {
    _timerStarted = false;
    return super.close();
  }
}
