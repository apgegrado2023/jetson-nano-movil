import 'package:flutter_application_prgrado/core/usecase/usecase.dart';
import 'package:flutter_application_prgrado/domain/repository/prototype_repository.dart';

class ConnectionUseCase implements UseCaseNoParams<bool> {
  final PrototypeRepository _prototypeRepository;

  ConnectionUseCase(this._prototypeRepository);

  @override
  Future<bool> call() async {
    return await _prototypeRepository.connect();
  }
}
