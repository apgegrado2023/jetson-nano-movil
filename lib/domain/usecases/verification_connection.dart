import 'package:flutter_application_prgrado/core/usecase/usecase.dart';
import 'package:flutter_application_prgrado/domain/repository/prototype_repository.dart';

class VerificationConnectionUseCase implements UseCaseNoParams<bool> {
  final PrototypeRepository _prototypeRepository;

  VerificationConnectionUseCase(this._prototypeRepository);

  @override
  Future<bool> call() async {
    return await _prototypeRepository.isConnect();
  }
}
