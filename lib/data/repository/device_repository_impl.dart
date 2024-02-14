import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_application_prgrado/config/utils/generate_code.dart';
import 'package:flutter_application_prgrado/core/resources/data_state.dart';
import 'package:flutter_application_prgrado/data/data_sources/remote/prototype/data_source_prototype_service.dart';
import 'package:flutter_application_prgrado/data/data_sources/remote/prototype/device_api_service.dart';
import 'package:flutter_application_prgrado/data/models/prototype/information_system.dart';
import 'package:flutter_application_prgrado/data/models/prototype/request.dart';
import 'package:flutter_application_prgrado/domain/repository/device_repository.dart';
import 'package:http/http.dart';

class DeviceRepositoryImpl implements DeviceRepository {
  DeviceRepositoryImpl(
    //this.dataSourcePrototypeService,
    this._informationApiService,
    this._informationApiService2,
  );
  final DeviceApiService _informationApiService;
  final DeviceApiService2 _informationApiService2;
  //final DataSourcePrototypeService dataSourcePrototypeService;
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
      final info = await getInformation();
      if (info != null) {
        streamControllerSystem.sink.add(info);
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
  Future<SystemInfoModel?> getInformation() async {
    /*try {
      final uniqueCode = GenerateCode.generateUniqueCode();
      final request = RequestService(
        type: "service_info_device",
        command: uniqueCode,
      );

      final response = await dataSourcePrototypeService.request(request);

      if (response.responseStatus == StatusResponse.failed ||
          response.responseStatus == StatusResponse.serverNotConnected ||
          response.responseStatus == StatusResponse.problem) {
        return null;
      }
      final info = SystemInfoModel.fromJson(response.data!);
      return info;
    } catch (e) {
      log('$e');
      return null;
    }*/
    return null;
  }

  @override
  Future<DataState<SystemInfoModel>> getInformationDevice() async {
    try {
      final httpResponse = await _informationApiService.getSystemInfo();
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<bool>> checkConnection() async {
    try {
      final httpResponse = await _informationApiService.checkConnection();
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return const DataSuccess(true);
      } else {
        return DataFailed<bool>(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<bool>> checkConnection2() async {
    try {
      final httpResponse = await _informationApiService2.checkConnection();
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return const DataSuccess(true);
      } else {
        return DataFailed2<bool>(
          ClientException(httpResponse.response.body),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<SystemInfoModel>> getInformationDevice2() async {
    try {
      final httpResponse = await _informationApiService2.getSystemInfo();
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data!);
      } else {
        return DataFailed2(
          ClientException(httpResponse.response.body),
        );
      }
    } on ClientException catch (e) {
      return DataFailed2(e);
    }
  }
}
