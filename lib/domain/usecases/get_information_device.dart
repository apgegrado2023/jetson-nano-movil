import 'package:flutter_application_prgrado/core/resources/data_state.dart';
import 'package:flutter_application_prgrado/core/usecase/usecase.dart';
import 'package:flutter_application_prgrado/domain/entities/information_system.dart';
import 'package:flutter_application_prgrado/domain/repository/device_repository.dart';

class GetInformationDeviceUseCase
    implements UseCaseFuture<DataState<SystemInfoEntity?>, void> {
  final DeviceRepository _informationPrototypeRepository;

  GetInformationDeviceUseCase(this._informationPrototypeRepository);

  @override
  Future<DataState<SystemInfoEntity?>> call({void params}) {
    return _informationPrototypeRepository.getInformationDevice();
  }
}
