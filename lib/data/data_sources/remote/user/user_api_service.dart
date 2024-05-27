import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_application_prgrado/core/resources/data_state.dart';
import 'package:flutter_application_prgrado/data/data_sources/api_method.dart';
import 'package:flutter_application_prgrado/data/models/prototype/information_system.dart';
import 'package:retrofit/retrofit.dart';
import 'dart:convert' as convert;
import 'package:dio/dio.dart';
import 'package:flutter_application_prgrado/core/constants/constants.dart';
import 'package:flutter_application_prgrado/core/resources/http_state.dart';
import 'package:flutter_application_prgrado/data/data_sources/remote/service_base/http_response.dart';
import 'package:flutter_application_prgrado/data/data_sources/remote/service_base/service_api.dart';

import 'package:flutter_application_prgrado/data/models/user.dart';

class UserApiService {
  final Dio dio;

  UserApiService(this.dio);

  Future<bool> insert(UserModel user) async {
    try {
      await ApiMethod.post(
        dio: dio,
        uri: ApiBaseURL.pathSegments(['user']),
        data: user.toJson(),
      );

      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> changePassword(
    String id,
    String oldPassword,
    String newPassword,
  ) async {
    try {
      await ApiMethod.post(
        dio: dio,
        uri: ApiBaseURL.pathSegments(['change_password', id]),
        data: {'old_password': oldPassword, 'new_password': newPassword},
      );

      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> getLogin(
    String userName,
    String password,
  ) async {
    try {
      final response = await ApiMethod.post(
        dio: dio,
        uri: ApiBaseURL.pathSegments(['login']),
        options: Options(method: 'POST'),
        data: {'user_name': userName, 'password': password},
      );

      var json = jsonDecode(response.$1);
      final result = UserModel.fromJson(json);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> getById(String id) async {
    try {
      final response = await ApiMethod.get(
        dio: dio,
        uri: ApiBaseURL.pathSegments(['user', id]),
      );

      var json = convert.jsonDecode(response);
      final result = UserModel.fromJson(json);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> updateFileUser({
    required String id,
    required Map<String, dynamic> body,
  }) async {
    try {
      final response = await ApiMethod.patch(
        dio: dio,
        uri: ApiBaseURL.pathSegments(['user', id]),
        data: body,
      );

      final json = jsonDecode(response);
      final result = UserModel.fromJson(json);
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
