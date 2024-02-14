import 'package:flutter_application_prgrado/core/resources/data_state.dart';

import '../../data/models/prototype/information_system.dart';

abstract class DeviceRepository {
  Stream<SystemInfoModel> get informationStream;
  void dispose();
  void stopTimer();
  Future<SystemInfoModel?> getInformation();
  Future<DataState<SystemInfoModel?>> getInformationDevice();
  Future<DataState<SystemInfoModel>> getInformationDevice2();
  Future<DataState<bool>> checkConnection();

  Future<DataState<bool>> checkConnection2();
}
