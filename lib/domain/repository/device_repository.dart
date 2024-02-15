import 'package:flutter_application_prgrado/core/resources/data_state.dart';

import '../../data/models/prototype/information_system.dart';

abstract class DeviceRepository {
  Stream<SystemInfoModel> get informationStream;
  void dispose();
  void stopTimer();
  Future<DataState<SystemInfoModel?>> getInformationDevice();
  Future<DataState<bool>> checkConnection();
}
