import 'package:flutter_application_prgrado/core/usecase/usecase.dart';
import 'package:flutter_application_prgrado/domain/repository/prototype_device_repository.dart';

class ConnectionProtypeVerificationUseCase
    implements UseCaseFuture<bool, void> {
  final PrototypeDeviceRepository prototypeDeviceRepository;

  ConnectionProtypeVerificationUseCase(this.prototypeDeviceRepository);

  @override
  Future<bool> call({void params}) async {
    return await prototypeDeviceRepository.isConnect();
  }
}
