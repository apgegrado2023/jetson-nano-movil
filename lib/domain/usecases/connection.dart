import 'package:flutter_application_prgrado/core/usecase/usecase.dart';
import 'package:flutter_application_prgrado/domain/repository/prototype_repository.dart';

class ConnectionUseCase implements UseCaseFuture<bool, void> {
  final PrototypeRepository _prototypeRepository;

  ConnectionUseCase(this._prototypeRepository);

  @override
  Future<bool> call({void params}) async {
    return await _prototypeRepository.connect();
  }
}
