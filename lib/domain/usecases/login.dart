import 'package:flutter_application_prgrado/core/resources/data_state.dart';
import 'package:flutter_application_prgrado/core/usecase/usecase.dart';
import 'package:flutter_application_prgrado/domain/entities/user.dart';
import 'package:flutter_application_prgrado/domain/repository/user_repository.dart';

class LoginUseCase
    implements UseCaseFuture<DataState<UserEntity>, LoginParams> {
  final UserRepository _userRepository;

  LoginUseCase(this._userRepository);

  @override
  Future<DataState<UserEntity>> call({LoginParams? params}) {
    print(params.toString());
    return _userRepository.getByParams(params!.userName, params.password);
  }
}

class LoginParams {
  final String userName;
  final String password;

  LoginParams(this.userName, this.password);
}
