import 'package:flutter_application_prgrado/core/resources/data_state.dart';

import '../../data/models/prototype/information_system.dart';

abstract class DeviceRepository {
  Future<DataState<SystemInfoModel?>> getInformationDevice();
  Future<DataState<bool>> checkConnection(bool isSingle);

  DataState<(Uri, Uri)> getUriVideoCameras();
}
