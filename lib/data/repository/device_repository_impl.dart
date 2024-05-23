import 'dart:async';
import 'dart:io';

import 'package:flutter_application_prgrado/core/resources/data_state.dart';
import 'package:flutter_application_prgrado/core/resources/http_state.dart';
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
  Future<DataState<bool>> checkConnection(bool isSingle) async {
    //try {
    final httpState = await _informationApiService.checkDConnection(isSingle);
    if (httpState is HttpSuccess) {
      return DataSuccess(httpState.httpResponse!.data);
    } else {
      return DataFailed2(httpState.error!);
    }
    /*} on ClientException catch (e) {
      return DataFailed(e);
    }*/
  }

  @override
  Future<DataState<SystemInfoModel>> getInformationDevice() async {
    final httpState = await _informationApiService.getDSystemInfo();
    if (httpState is HttpSuccess) {
      return DataSuccess(httpState.httpResponse!.data);
    } else {
      return DataFailed2(httpState.error!);
    }
  }
}
