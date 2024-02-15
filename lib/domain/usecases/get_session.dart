import 'package:flutter_application_prgrado/core/resources/data_state.dart';
import 'package:flutter_application_prgrado/core/usecase/usecase.dart';
import 'package:flutter_application_prgrado/domain/entities/user.dart';
import 'package:flutter_application_prgrado/domain/repository/device_repository.dart';
import 'package:flutter_application_prgrado/domain/repository/session_repository.dart';

class GetSessionUseCase implements UseCaseFuture<DataState<UserEntity?>, void> {
  final SessionRepository _sessionRepository;

  GetSessionUseCase(this._sessionRepository);

  @override
  Future<DataState<UserEntity?>> call({void params}) {
    return _sessionRepository.getToSession();
  }
}
