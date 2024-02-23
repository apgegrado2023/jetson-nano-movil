import 'package:flutter_application_prgrado/core/resources/data_state.dart';
import 'package:flutter_application_prgrado/core/usecase/usecase.dart';
import 'package:flutter_application_prgrado/domain/repository/session_repository.dart';

class RemoveSessionUseCase implements UseCaseFuture<DataState<bool>, void> {
  final SessionRepository _sessionRepository;

  RemoveSessionUseCase(this._sessionRepository);

  @override
  Future<DataState<bool>> call({void params}) {
    return _sessionRepository.removeToSession();
  }
}
