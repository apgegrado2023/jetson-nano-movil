import 'package:flutter_application_prgrado/core/usecase/usecase.dart';
import 'package:flutter_application_prgrado/data/models/prototype/information_system.dart';
import 'package:flutter_application_prgrado/domain/repository/device_repository.dart';

class GetInformationPrototypeUseCase
    implements UseCase<Stream<SystemInfoModel>, void> {
  final DeviceRepository informationPrototypeRepository;

  GetInformationPrototypeUseCase(this.informationPrototypeRepository);

  @override
  Stream<SystemInfoModel> call({void params}) {
    return informationPrototypeRepository.informationStream;
  }
}
