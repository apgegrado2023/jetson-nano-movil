import 'dart:io';
import 'dart:math';
import 'package:flutter_application_prgrado/core/resources/data_state.dart';
import 'package:flutter_application_prgrado/core/resources/http_state.dart';
import 'package:flutter_application_prgrado/data/data_sources/exceptions.dart';
import 'package:flutter_application_prgrado/data/data_sources/failures.dart';
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
    try {
      final httpState = await _userApiService.insert(
        UserModel.fromEntity(user),
      );

      return DataSuccess(httpState);
    } on RequestException {
      return DataFailed(RequestFailure());
    } on SocketException {
      return DataFailed(SocketFailure());
    } on ResultException catch (e) {
      return DataFailed(ResultFailure(e.message));
    } on NoInternetException {
      return DataFailed(NoInternetFailure());
    } on ConflictException {
      return DataFailed(ConflictFailure());
    }
  }

  @override
  Future<DataState<UserModel>> getById(String id) async {
    try {
      final httpState = await _userApiService.getById(id);
      return DataSuccess(httpState);
    } on RequestException {
      return DataFailed(RequestFailure());
    } on SocketException {
      return DataFailed(SocketFailure());
    } on ResultException catch (e) {
      return DataFailed(ResultFailure(e.message));
    } on NoInternetException {
      return DataFailed(NoInternetFailure());
    }
  }

  @override
  Future<DataState<UserModel>> getByParams(
    String userName,
    String password,
  ) async {
    try {
      final httpState = await _userApiService.getLogin(userName, password);

      return DataSuccess(httpState);
    } on RequestException {
      return DataFailed(RequestFailure());
    } on SocketException {
      return DataFailed(SocketFailure());
    } on ResultException catch (e) {
      return DataFailed(ResultFailure(e.message));
    } on NotFoundException catch (e) {
      return DataFailed(NotFoundFailure(e.message ?? 'Recurso no encontrado'));
    } on NoInternetException {
      return DataFailed(NoInternetFailure());
    }
  }

  @override
  Future<DataState<UserEntity>> updateFiled(
    String id,
    Map<String, dynamic> body,
  ) async {
    try {
      final httpState = await _userApiService.updateFileUser(
        id: id,
        body: body,
      );

      return DataSuccess(httpState);
    } on RequestException {
      return DataFailed(RequestFailure());
    } on SocketException {
      return DataFailed(SocketFailure());
    } on ResultException catch (e) {
      return DataFailed(ResultFailure(e.message));
    } on NoInternetException {
      return DataFailed(NoInternetFailure());
    }
  }

  @override
  Future<DataState<bool>> changePassword(
    String newPassword,
    String oldPassword,
    String id,
  ) async {
    try {
      final httpState = await _userApiService.changePassword(
        id,
        oldPassword,
        newPassword,
      );

      return DataSuccess(httpState);
    } on RequestException {
      return DataFailed(RequestFailure());
    } on SocketException {
      return DataFailed(SocketFailure());
    } on ResultException catch (e) {
      return DataFailed(ResultFailure(e.message));
    } on NoInternetException {
      return DataFailed(NoInternetFailure());
    }
  }
}
