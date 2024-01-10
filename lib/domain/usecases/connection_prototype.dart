import 'package:flutter_application_prgrado/core/usecase/usecase.dart';
import 'package:flutter_application_prgrado/domain/repository/prototype_device_repository.dart';

class ConnectionPrototypeUseCase implements UseCaseFuture<bool, void> {
  final PrototypeDeviceRepository _prototypeDeviceRepository;

  ConnectionPrototypeUseCase(this._prototypeDeviceRepository);

  @override
  Future<bool> call({void params}) async {
    return await _prototypeDeviceRepository.connect();
  }
}
