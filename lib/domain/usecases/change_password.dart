import 'package:flutter_application_prgrado/core/resources/data_state.dart';
import 'package:flutter_application_prgrado/core/usecase/usecase.dart';
import 'package:flutter_application_prgrado/domain/repository/device_repository.dart';
import 'package:flutter_application_prgrado/domain/repository/user_repository.dart';

class ChangePasswordUseCase
    implements UseCaseFuture<DataState<bool>, ChangePasswordParams> {
  final UserRepository _userRepository;

  ChangePasswordUseCase(this._userRepository);

  @override
  Future<DataState<bool>> call({ChangePasswordParams? params}) {
    return _userRepository.changePassword(
      params!.newPassword,
      params.oldPassword,
      params.id,
    );
  }
}

class ChangePasswordParams {
  final String id;
  final String newPassword;
  final String oldPassword;

  ChangePasswordParams(this.id, this.newPassword, this.oldPassword);
}
