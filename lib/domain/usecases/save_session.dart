import 'package:flutter_application_prgrado/core/resources/data_state.dart';
import 'package:flutter_application_prgrado/core/usecase/usecase.dart';
import 'package:flutter_application_prgrado/domain/entities/article.dart';
import 'package:flutter_application_prgrado/domain/entities/user.dart';
import 'package:flutter_application_prgrado/domain/repository/article_repository.dart';
import 'package:flutter_application_prgrado/domain/repository/session_repository.dart';
import 'package:flutter_application_prgrado/domain/repository/user_repository.dart';

class SaveSessionUseCase implements UseCaseFuture<DataState<bool>, UserEntity> {
  final SessionRepository _sessionRepository;

  SaveSessionUseCase(this._sessionRepository);

  @override
  Future<DataState<bool>> call({UserEntity? params}) {
    return _sessionRepository.saveToSession(params!);
  }
}
