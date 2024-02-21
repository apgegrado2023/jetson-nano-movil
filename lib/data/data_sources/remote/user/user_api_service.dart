import 'dart:developer';
import 'dart:io';
import 'dart:convert' as convert;
import 'package:flutter_application_prgrado/core/constants/constants.dart';
import 'package:flutter_application_prgrado/data/data_sources/remote/service_base/http_response.dart';
import 'package:flutter_application_prgrado/data/data_sources/remote/service_base/service_api.dart';

import 'package:flutter_application_prgrado/data/models/user.dart';

class UserApiService {
  Future<HttpServiceResponse<bool>> insert(UserModel user) async {
    final response =
        await ServiceApi.post(ApiBaseURL.pathSegments(['user']), user.toJson());
    if (response.statusCode == HttpStatus.created) {
      var json = convert.jsonDecode(response.body) as Map<String, dynamic>;
      print(json);
      return HttpServiceResponse(true, response);
    }

    return HttpServiceResponse(false, response);
  }

  Future<HttpServiceResponse<UserModel?>> getById(String id) async {
    final response =
        await ServiceApi.get(ApiBaseURL.pathSegments(['user', id]));
    if (response.statusCode == HttpStatus.ok) {
      var json = convert.jsonDecode(response.body) as Map<String, dynamic>;
      return HttpServiceResponse(UserModel.fromJson(json), response);
    }

    return HttpServiceResponse(null, response);
  }

  Future<HttpServiceResponse<UserModel?>> getLogin(
      String userName, String password) async {
    final response = await ServiceApi.post(
      ApiBaseURL.pathSegments(['login']),
      {'username': userName, 'password': password},
    );
    if (response.statusCode == HttpStatus.ok) {
      var json = convert.jsonDecode(response.body) as Map<String, dynamic>;
      return HttpServiceResponse(UserModel.fromJson(json), response);
    }

    return HttpServiceResponse(null, response);
  }
}
