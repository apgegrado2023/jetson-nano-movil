import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_prgrado/core/app/cubit/notification_app_cubit.dart';
import 'package:flutter_application_prgrado/core/resources/data_state.dart';
import 'package:flutter_application_prgrado/data/data_sources/failures.dart';
import 'package:flutter_application_prgrado/domain/usecases/getUriCameras.dart';
import 'package:flutter_application_prgrado/presentation/pages/information_device/cubit/information_device_cubit.dart';
import 'package:flutter_application_prgrado/presentation/pages/information_device/notification.dart';

import '../../../../domain/usecases/check_connection.dart';
part 'video_camera_state.dart';

class VideoCameraCubit extends Cubit<VideoCameraState> {
  VideoCameraCubit(
    this._getUriUseCase,
    this._checkConnectionUseCase,
  ) : super(VideoCameraState());

  final GetUriUseCase _getUriUseCase;
  final CheckConnectionUseCase _checkConnectionUseCase;

  bool _timerStarted = false;
  Future<void> initial() async {
    final uris = _getUriUseCase();
    if (uris is DataSuccess) {
      emit(state.copyWith(
        cameraOne: uris.data!.$1,
        cameraTwo: uris.data!.$2,
      ));
    }
    verificationConnection();
  }

  Future<void> verificationConnection() async {
    _timerStarted = true;
    while (_timerStarted) {
      await check_connection();
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
      if (state.statusConnection == StatusConnection.disconnected) return;
      NotificationInteractor.onChangeNotification(
        NotificationSyn.noConnection,
      );
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
}
