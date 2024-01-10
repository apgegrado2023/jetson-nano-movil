import 'package:flutter_application_prgrado/core/usecase/usecase.dart';
import 'package:flutter_application_prgrado/domain/repository/prototype_repository.dart';

class VerificationConnectionUseCase implements UseCaseFuture<bool, void> {
  final PrototypeRepository _prototypeRepository;

  VerificationConnectionUseCase(this._prototypeRepository);

  @override
  Future<bool> call({void params}) async {
    return await _prototypeRepository.isConnect();
  }
}
