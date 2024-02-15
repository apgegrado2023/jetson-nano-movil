import 'package:flutter_application_prgrado/core/resources/data_state.dart';
import 'package:flutter_application_prgrado/core/usecase/usecase.dart';
import 'package:flutter_application_prgrado/domain/entities/article.dart';
import 'package:flutter_application_prgrado/domain/entities/user.dart';
import 'package:flutter_application_prgrado/domain/repository/article_repository.dart';
import 'package:flutter_application_prgrado/domain/repository/user_repository.dart';

class SaveUserUseCase implements UseCaseFuture<DataState<bool>, UserEntity> {
  final UserRepository _userRepository;

  SaveUserUseCase(this._userRepository);

  @override
  Future<DataState<bool>> call({UserEntity? params}) {
    return _userRepository.insert(params!);
  }
}
