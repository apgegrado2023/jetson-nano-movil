import 'dart:async';
import 'dart:io';

import 'package:flutter_application_prgrado/core/resources/data_state.dart';
import 'package:flutter_application_prgrado/data/data_sources/exceptions.dart';
import 'package:flutter_application_prgrado/data/data_sources/failures.dart';
import 'package:flutter_application_prgrado/data/data_sources/remote/device/device_api_service.dart';
import 'package:flutter_application_prgrado/data/models/prototype/information_system.dart';
import 'package:flutter_application_prgrado/domain/repository/device_repository.dart';

class DeviceRepositoryImpl implements DeviceRepository {
  DeviceRepositoryImpl(
    this._informationApiService,
  );
  final DeviceApiService _informationApiService;

  @override
  Future<DataState<bool>> checkConnection(bool isSingle) async {
    try {
      final result = await _informationApiService.checkDConnection(isSingle);

      return DataSuccess(result);
    } on RequestException {
      return DataFailed(RequestFailure());
    } on SocketException {
      return DataFailed(SocketFailure());
    } on ResultException catch (e) {
      return DataFailed(ResultFailure(e.message));
    } on NoInternetException {
      return DataFailed(NoInternetFailure());
    }
  }

  @override
  Future<DataState<SystemInfoModel>> getInformationDevice() async {
    try {
      final result = await _informationApiService.getDSystemInfo();

      return DataSuccess(result);
    } on RequestException {
      return DataFailed(RequestFailure());
    } on SocketException {
      return DataFailed(SocketFailure());
    } on ResultException catch (e) {
      return DataFailed(ResultFailure(e.message));
    }
  }
}
