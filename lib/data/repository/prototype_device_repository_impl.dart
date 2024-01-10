import 'package:flutter_application_prgrado/data/data_sources/remote/prototype/data_source_prototype_service.dart';
import 'package:flutter_application_prgrado/domain/repository/prototype_device_repository.dart';

class PrototypeDeviceRepositoryImpl extends PrototypeDeviceRepository {
  final DataSourcePrototypeService dataSourcePrototypeService;

  PrototypeDeviceRepositoryImpl(this.dataSourcePrototypeService);

  @override
  Future<bool> connect() async {
    return await dataSourcePrototypeService.connectPrototype();
  }

  @override
  Future<bool> isConnect() {
    return dataSourcePrototypeService.isConnected();
  }
}
