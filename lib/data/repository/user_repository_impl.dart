import 'dart:math';
import 'package:flutter_application_prgrado/core/resources/data_state.dart';
import 'package:flutter_application_prgrado/core/resources/http_state.dart';
import 'package:flutter_application_prgrado/data/data_sources/remote/user/user_api_service.dart';
import 'package:flutter_application_prgrado/data/models/user.dart';
import 'package:flutter_application_prgrado/domain/entities/user.dart';
import 'package:flutter_application_prgrado/domain/repository/user_repository.dart';

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
    //try {
    final httpState = await _userApiService.insertD(UserModel.fromEntity(user));
    if (httpState is HttpSuccess) {
      return DataSuccess(httpState.httpResponse!.data);
    } else {
      return DataFailed2(httpState.error!);
    }
    /*} on ClientException catch (e) {
      return DataFailed(e);
    }*/
  }

  @override
  Future<DataState<UserModel>> getById(String id) async {
    final httpState = await _userApiService.getDById(id);
    if (httpState is HttpSuccess) {
      return DataSuccess(httpState.httpResponse!.data);
    } else {
      return DataFailed2(httpState.error!);
    }
  }

  @override
  Future<DataState<UserModel>> getByParams(
      String userName, String password) async {
    //try {
    final httpState = await _userApiService.getDLogin(userName, password);
    if (httpState is HttpSuccess) {
      return DataSuccess(httpState.httpResponse!.data);
    } else {
      return DataFailed2(httpState.error!);
    }
    /*} on ClientException catch (e) {
      return DataFailed(e);
    }*/
  }

  @override
  Future<DataState<UserEntity>> updateFiled(
      String id, Map<String, dynamic> body) async {
    final httpState = await _userApiService.updateFile(id, body);
    if (httpState is HttpSuccess) {
      return DataSuccess(httpState.httpResponse!.data);
    } else {
      return DataFailed2(httpState.error!);
    }
  }

  @override
  Future<DataState<bool>> changePassword(
      String newPassword, String oldPassword, String id) async {
    final httpState = await _userApiService.changePassword(
      id,
      oldPassword,
      newPassword,
    );
    if (httpState is HttpSuccess) {
      return DataSuccess(httpState.httpResponse!.data);
    } else {
      return DataFailed2(httpState.error!);
    }
  }
}
