import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_prgrado/core/app/cubit/notification_app_cubit.dart';
import 'package:flutter_application_prgrado/data/data_sources/failures.dart';
import 'package:flutter_application_prgrado/presentation/pages/information_device/cubit/information_device_cubit.dart';
import 'package:flutter_application_prgrado/presentation/pages/information_device/notification.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../domain/entities/detection_history.dart';
import '../../../../domain/usecases/check_connection.dart';
import '../../../../domain/usecases/get_detection_history.dart';

part 'detection_history_state.dart';

class DetectionHistoryCubit extends Cubit<DetectionHistoryState> {
  DetectionHistoryCubit(
    this._detectionHistoryUseCase,
    this._checkConnectionUseCase,
  ) : super(DetectionHistoryState());

  final GetDetectionHistoryUseCase _detectionHistoryUseCase;
  final CheckConnectionUseCase _checkConnectionUseCase;

  bool _timerStarted = false;

  init() async {
    await loadDataDetections();
    verificationConnection();
  }

  Future<void> loadDataDetections() async {
    final httpResponse = await _detectionHistoryUseCase();
    if (httpResponse is DataSuccess) {
      emit(
        state.copyWith(
          listMemberEntity: httpResponse.data!,
          listMemberEntityOriginal: httpResponse.data!,
          statusConnection: StatusConnection.connected,
          detectHistoryDevice: DetectHistoryDevice.success,
          index: 0,
        ),
      );
    } else if (httpResponse is DataFailed) {
      if (httpResponse.failure is NoInternetFailure) {
        emit(state.copyWith(
          statusConnection: StatusConnection.disconnected,
          detectHistoryDevice: DetectHistoryDevice.error,
        ));
        NotificationInteractor.onChangeNotification(
          NotificationSyn.noConnection,
        );
      } else {
        emit(state.copyWith(
          detectHistoryDevice: DetectHistoryDevice.error,
        ));
        NotificationInteractor.onChangeNotification(
          NotificationSyn.errorGetData,
        );
      }
    }
  }

  Future<void> verificationConnection() async {
    _timerStarted = true;
    while (_timerStarted) {
      await check_connection();

      final status = state.statusConnection;
      if (status != StatusConnection.connected) {
        loadDataDetections();
      }

      await Future.delayed(Duration(seconds: 8));
    }
  }

  Future<void> check_connection() async {
    final httpResponse = await _checkConnectionUseCase(true);
    if (httpResponse is DataSuccess) {
      emit(
        state.copyWith(
          statusConnection: StatusConnection.connected,
        ),
      );
    } else if (httpResponse is DataFailed) {
      if (httpResponse.failure is NoInternetFailure) {
        if (state.statusConnection == StatusConnection.disconnected) return;
        emit(state.copyWith(
          statusConnection: StatusConnection.disconnected,
        ));
      } else {
        emit(state.copyWith(
          statusConnection: StatusConnection.disconnected,
        ));
      }
    }
  }

  searchMember(String character) {
    if (state.listMemberEntityOriginal.isEmpty) return;

    if (state.index == 0) {
      var filteredMembers = state.listMemberEntityOriginal
          .where((member) => member.description!
              .toLowerCase()
              .contains(character.toLowerCase()))
          .toList();

      emit(state.copyWith(listMemberEntity: filteredMembers));
      return;
    }
    var filteredMembers = state.listMemberEntityOriginal!
        .where((member) =>
            member.description!
                .toLowerCase()
                .contains(character.toLowerCase()) &&
            member.typeDetection == state.index)
        .toList();

    emit(state.copyWith(listMemberEntity: filteredMembers));
  }

  void onIndexChanged(int index) {
    if (index == 0) {
      var filteredMembers = state.listMemberEntityOriginal!
          .where((member) => member.description!.toLowerCase().contains(''))
          .toList();

      emit(state.copyWith(listMemberEntity: filteredMembers, index: index));
      return;
    }

    var filteredMembers = state.listMemberEntityOriginal!
        .where((member) => member.typeDetection! == index)
        .toList();
    emit(state.copyWith(listMemberEntity: filteredMembers, index: index));
  }

  @override
  Future<void> close() {
    print("se cierra");
    _timerStarted = false;
    return super.close();
  }
}
