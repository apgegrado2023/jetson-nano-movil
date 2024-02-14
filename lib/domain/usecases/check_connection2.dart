import 'package:flutter_application_prgrado/core/resources/data_state.dart';
import 'package:flutter_application_prgrado/core/usecase/usecase.dart';
import 'package:flutter_application_prgrado/domain/repository/device_repository.dart';

class CheckConnection2UseCase implements UseCaseFuture<DataState<bool>, void> {
  final DeviceRepository _deviceRepository;

  CheckConnection2UseCase(this._deviceRepository);

  @override
  Future<DataState<bool>> call({void params}) {
    return _deviceRepository.checkConnection2();
  }
}
