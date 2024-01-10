import 'package:flutter_application_prgrado/core/usecase/usecase.dart';
import 'package:flutter_application_prgrado/data/models/prototype/information_system.dart';
import 'package:flutter_application_prgrado/domain/repository/information_prototype_repository.dart';

class GetInformationPrototypeUseCase
    implements UseCase<Stream<SystemInfo>, void> {
  final InformationPrototypeRepository informationPrototypeRepository;

  GetInformationPrototypeUseCase(this.informationPrototypeRepository);

  @override
  Stream<SystemInfo> call({void params}) {
    return informationPrototypeRepository.informationStream;
  }
}
