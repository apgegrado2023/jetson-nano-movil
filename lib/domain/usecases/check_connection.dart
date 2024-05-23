import 'package:flutter_application_prgrado/core/resources/data_state.dart';
import 'package:flutter_application_prgrado/core/usecase/usecase.dart';
import 'package:flutter_application_prgrado/domain/repository/device_repository.dart';

class CheckConnectionUseCase
    implements UseCaseFutureSafe<DataState<bool>, bool> {
  final DeviceRepository _deviceRepository;

  CheckConnectionUseCase(this._deviceRepository);

  @override
  Future<DataState<bool>> call(bool params) {
    return _deviceRepository.checkConnection(params);
  }
}
