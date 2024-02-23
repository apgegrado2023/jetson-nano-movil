import 'dart:developer';
import 'dart:io';
import 'package:flutter_application_prgrado/core/resources/data_state.dart';
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

  Future<HttpState<bool>> insertD(UserModel user) async {
    try {
      final response = await dio.postUri(ApiBaseURL.pathSegments(['user']),
          data: user.toJson());
      if (response.statusCode == HttpStatus.created) {
        //var json = convert.jsonDecode(response.data) as Map<String, dynamic>;
        final httpResponse = HttpResponse(true, response);
        //print(json);
        return HttpSuccess<bool>(httpResponse);
      } else {
        final httpResponse = HttpResponse(false, response);
        return HttpSuccess<bool>(httpResponse);
      }
    } on DioException catch (e) {
      print(e);
      return HttpFailed(e);
    } on SocketException catch (s) {
      return HttpFailed(
        DioException(
          requestOptions: RequestOptions(),
          message: s.message,
        ),
      );
    } catch (e) {
      return HttpFailed(
        DioException(
          requestOptions: RequestOptions(),
          message: e.toString(),
        ),
      );
    }
  }

  Future<HttpState<bool>> changePassword(
    String id,
    String oldPassword,
    String newPassword,
  ) async {
    try {
      final response = await dio.postUri(
          ApiBaseURL.pathSegments(['change_password', id]),
          data: {'old_password': oldPassword, 'new_password': newPassword});
      if (response.statusCode == HttpStatus.ok) {
        //var json = convert.jsonDecode(response.data) as Map<String, dynamic>;
        final httpResponse = HttpResponse(true, response);
        //print(json);
        return HttpSuccess<bool>(httpResponse);
      } else {
        return HttpFailed(
          DioException(
            error: response.statusMessage,
            response: response,
            type: DioExceptionType.badResponse,
            requestOptions: response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      print(e);
      return HttpFailed(
        DioException(
          error: e.error,
          response: e.response ??
              Response(
                  requestOptions: e.requestOptions,
                  statusCode: HttpStatus.serviceUnavailable),
          type: e.type,
          requestOptions: e.requestOptions,
        ),
      );
    } on SocketException catch (s) {
      return HttpFailed(
        DioException(
          requestOptions: RequestOptions(),
          message: s.message,
        ),
      );
    } catch (e) {
      return HttpFailed(
        DioException(
          requestOptions: RequestOptions(),
          message: e.toString(),
        ),
      );
    }
  }

  Future<HttpState<UserModel>> updateFile(
      String id, Map<String, dynamic> body) async {
    try {
      final response = await dio.patchUri(
        ApiBaseURL.pathSegments(['user', id]),
        data: body,
      );
      if (response.statusCode == HttpStatus.ok) {
        var json = response.data;
        final httpResponse = HttpResponse(UserModel.fromJson(json), response);
        return HttpSuccess(httpResponse);
      } else {
        return HttpFailed(
          DioException(
            error: response.statusMessage,
            response: response,
            type: DioExceptionType.badResponse,
            requestOptions: response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      return HttpFailed(e);
    } on SocketException catch (s) {
      return HttpFailed(
        DioException(requestOptions: RequestOptions(), message: s.message),
      );
    } catch (e) {
      return HttpFailed(
        DioException(
          requestOptions: RequestOptions(),
          message: e.toString(),
          type: DioExceptionType.unknown,
        ),
      );
    }
  }

  Future<HttpState<UserModel>> getDLogin(
      String userName, String password) async {
    try {
      final response = await dio.postUri(
        ApiBaseURL.pathSegments(['login']),
        data: {'user_name': userName, 'password': password},
      );
      if (response.statusCode == HttpStatus.ok) {
        var json = response.data;
        final httpResponse = HttpResponse(UserModel.fromJson(json), response);
        return HttpSuccess(httpResponse);
      } else {
        return HttpFailed(
          DioException(
            error: response.statusMessage,
            response: response,
            type: DioExceptionType.badResponse,
            requestOptions: response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      return HttpFailed(e);
    } on SocketException catch (s) {
      return HttpFailed(
        DioException(requestOptions: RequestOptions(), message: s.message),
      );
    } catch (e) {
      return HttpFailed(
        DioException(
          requestOptions: RequestOptions(),
          message: e.toString(),
          type: DioExceptionType.unknown,
        ),
      );
    }
  }

  Future<HttpState<UserModel>> getDById(String id) async {
    try {
      final response = await dio.getUri(ApiBaseURL.pathSegments(['user', id]));
      if (response.statusCode == HttpStatus.ok) {
        var json = convert.jsonDecode(response.data) as Map<String, dynamic>;
        final httpResponse = HttpResponse(UserModel.fromJson(json), response);
        return HttpSuccess(httpResponse);
      } else {
        return HttpFailed<UserModel>(
          DioException(
            error: response.statusMessage,
            response: response,
            type: DioExceptionType.badResponse,
            requestOptions: response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      return HttpFailed(e);
    } on SocketException catch (s) {
      return HttpFailed(
        DioException(requestOptions: RequestOptions(), message: s.message),
      );
    } catch (e) {
      return HttpFailed(
        DioException(
          requestOptions: RequestOptions(),
          message: e.toString(),
          type: DioExceptionType.unknown,
        ),
      );
    }
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
