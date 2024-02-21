import 'dart:async';
import 'dart:io';

import 'package:flutter_application_prgrado/core/resources/data_state.dart';
import 'package:flutter_application_prgrado/data/data_sources/remote/device/device_api_service.dart';
import 'package:flutter_application_prgrado/data/models/prototype/information_system.dart';
import 'package:flutter_application_prgrado/domain/repository/device_repository.dart';
import 'package:http/http.dart';

class DeviceRepositoryImpl implements DeviceRepository {
  DeviceRepositoryImpl(
    this._informationApiService,
  );
  final DeviceApiService _informationApiService;

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
