import 'dart:io';
import 'dart:math';
import 'package:flutter_application_prgrado/core/resources/data_state.dart';
import 'package:flutter_application_prgrado/data/data_sources/remote/user/user_api_service.dart';
import 'package:flutter_application_prgrado/data/models/user.dart';
import 'package:flutter_application_prgrado/domain/entities/user.dart';
import 'package:flutter_application_prgrado/domain/repository/user_repository.dart';
import 'package:http/http.dart';

class UserRepositoryImpl extends UserRepository {
  final UserApiService _userApiService;

  UserRepositoryImpl(this._userApiService);

  String generateUniqueCode() {
    final random = Random();
    final uniqueCode = random.nextInt(90000) + 10000;
    return uniqueCode.toString();
  }

  @override
  Future<DataState<bool>> insert(UserEntity user) async {
    try {
      final httpResponse =
          await _userApiService.insert(UserModel.fromEntity(user));
      if (httpResponse.response.statusCode == HttpStatus.created) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          ClientException(httpResponse.response.body),
        );
      }
    } on ClientException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<UserModel>> getById(String id) async {
    try {
      final httpResponse = await _userApiService.getById(id);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data!);
      } else {
        return DataFailed(
          ClientException(httpResponse.response.body),
        );
      }
    } on ClientException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<UserModel>> getByParams(
      String userName, String password) async {
    try {
      final httpResponse = await _userApiService.getLogin(userName, password);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data!);
      } else {
        return DataFailed(
          ClientException(httpResponse.response.body),
        );
      }
    } on ClientException catch (e) {
      return DataFailed(e);
    }
  }
}
