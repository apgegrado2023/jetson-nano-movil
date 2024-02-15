import 'dart:async';
import 'dart:io';

import 'package:flutter_application_prgrado/core/resources/data_state.dart';
import 'package:flutter_application_prgrado/data/data_sources/remote/prototype/device_api_service.dart';
import 'package:flutter_application_prgrado/data/models/prototype/information_system.dart';
import 'package:flutter_application_prgrado/domain/repository/device_repository.dart';
import 'package:http/http.dart';

class DeviceRepositoryImpl implements DeviceRepository {
  DeviceRepositoryImpl(
    this._informationApiService,
  );
  final DeviceApiService _informationApiService;

  Timer? timer;
  StreamController<SystemInfoModel> streamControllerSystem =
      StreamController<SystemInfoModel>.broadcast();
  bool _timerStarted = false;

  @override
  Stream<SystemInfoModel> get informationStream {
    if (!_timerStarted) {
      _startTimer();
      _timerStarted = true;
    }
    return streamControllerSystem.stream;
  }

  void _startTimer() {
    streamControllerSystem = StreamController.broadcast();
    timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      final httpResponse = await _informationApiService.getSystemInfo();
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        streamControllerSystem.sink.add(httpResponse.data!);
      }
    });
  }

  @override
  void dispose() {
    _timerStarted = false;
    streamControllerSystem.close();
    timer?.cancel();
  }

  @override
  void stopTimer() {
    timer?.cancel();
  }

  @override
  Future<DataState<bool>> checkConnection() async {
    try {
      final httpResponse = await _informationApiService.checkConnection();
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return const DataSuccess(true);
      } else {
        return DataFailed(
          ClientException(httpResponse.response.body),
        );
      }
    } on ClientException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<SystemInfoModel>> getInformationDevice() async {
    try {
      final httpResponse = await _informationApiService.getSystemInfo();
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data!);
      } else {
        return DataFailed(
          ClientException(httpResponse.response.body),
        );
      }
    } on ClientException catch (e) {
      return DataFailed(e);
    }
  }
}
