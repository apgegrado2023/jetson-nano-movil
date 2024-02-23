import 'package:flutter_application_prgrado/core/resources/data_state.dart';
import 'package:flutter_application_prgrado/data/models/user.dart';
import 'package:flutter_application_prgrado/domain/entities/user.dart';

abstract class UserRepository {
  Future<DataState<bool>> insert(UserEntity user);
  Future<DataState<UserEntity>> updateFiled(
      String id, Map<String, dynamic> body);
  Future<DataState<UserModel>> getById(String id);

  Future<DataState<UserModel>> getByParams(String userName, String password);
  Future<DataState<bool>> changePassword(
      String newPassword, String oldPassword, String id);
}
