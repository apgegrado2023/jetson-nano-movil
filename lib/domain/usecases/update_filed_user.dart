import 'package:flutter_application_prgrado/core/resources/data_state.dart';
import 'package:flutter_application_prgrado/core/usecase/usecase.dart';
import 'package:flutter_application_prgrado/domain/entities/user.dart';
import 'package:flutter_application_prgrado/domain/repository/device_repository.dart';
import 'package:flutter_application_prgrado/domain/repository/session_repository.dart';
import 'package:flutter_application_prgrado/domain/repository/user_repository.dart';

class UpdateFileUserUseCase
    implements UseCaseFuture<DataState<UserEntity>, UpdateFileUserParams> {
  final UserRepository _userRepository;

  UpdateFileUserUseCase(this._userRepository);

  @override
  Future<DataState<UserEntity>> call({UpdateFileUserParams? params}) {
    return _userRepository.updateFiled(params!.id, {params.title: params.text});
  }
}

class UpdateFileUserParams {
  final String id;
  final String title;
  final String text;

  UpdateFileUserParams(this.id, this.title, this.text);
}
