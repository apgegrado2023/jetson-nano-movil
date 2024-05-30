import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_application_prgrado/data/data_sources/exceptions.dart';
import 'package:retrofit/retrofit.dart';

class ApiMethod<T> {
  static Future<String> get({
    required Dio dio,
    required Uri uri,
  }) async {
    try {
      final query = uri.toString();
      log('REQUEST $query ===> Done');
      final response = await dio.get<String>(query).timeout(
            const Duration(seconds: 10),
          );
      log('RESULT $query ===> ${response.data}');

      if (response.statusCode == 200) {
        return response.data!;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Request failed with status: ${response.statusCode}.',
        );
      }
    } on SocketException catch (e) {
      throw SocketException(e.message);
    } on TimeoutException catch (e) {
      throw TimeoutException(e.message);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        throw NoInternetException();
      } else if (e.response?.statusCode == 401) {
        throw UnauthorizedException();
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw TimeoutException(e.message);
      } else if (e.type == DioExceptionType.connectionTimeout) {
        throw TimeoutException(e.message);
      } else if (e.type == DioExceptionType.sendTimeout) {
        throw TimeoutException(e.message);
      } else if (e.response?.statusCode == 404) {
        throw NotFoundException(e.message);
      } else if (e.response?.statusCode == 409) {
        throw ConflictException(e.message);
      }
      throw RequestException();
    } on FormatException {
      throw RequestException();
    }
  }

  static Future<(String, Response)> post(
      {required Dio dio,
      required Uri uri,
      required Object? data,
      Options? options}) async {
    try {
      final query = uri.toString();
      log('REQUEST $query ===> Done');
      log('BODY $data ===> Done');
      final response = await dio.post<String>(
        query,
        data: data,
        options: options,
      );
      log('RESULT $query ===> ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return (response.data!, response);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Request failed with status: ${response.statusCode}.',
        );
      }
    } on SocketException catch (e) {
      throw SocketException(e.message);
    } on TimeoutException catch (e) {
      throw TimeoutException(e.message);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        throw NoInternetException();
      } else if (e.response?.statusCode == 401) {
        throw UnauthorizedException();
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw TimeoutException(e.message);
      } else if (e.type == DioExceptionType.connectionTimeout) {
        throw TimeoutException(e.message);
      } else if (e.type == DioExceptionType.sendTimeout) {
        throw TimeoutException(e.message);
      } else if (e.response?.statusCode == 404) {
        throw NotFoundException(e.message);
      } else if (e.response?.statusCode == 409) {
        throw ConflictException(e.message);
      }
      /*throw DioException(
        requestOptions: e.requestOptions,
        response: e.response,
        error: e.error,
      );*/
      throw RequestException();
    } on FormatException {
      throw RequestException();
    }
  }

  static Future<String> patch(
      {required Dio dio,
      required Uri uri,
      required Object? data,
      Options? options}) async {
    try {
      final query = uri.toString();
      log('REQUEST $query ===> Done');
      final response = await dio.patch<String>(
        query,
        data: data,
        options: options,
      );
      log('RESULT $query ===> ${response.data}');

      if (response.statusCode == 200) {
        return response.data!;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Request failed with status: ${response.statusCode}.',
        );
      }
    } on SocketException catch (e) {
      throw SocketException(e.message);
    } on TimeoutException catch (e) {
      throw TimeoutException(e.message);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        throw NoInternetException();
      } else if (e.response?.statusCode == 401) {
        throw UnauthorizedException();
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw TimeoutException(e.message);
      } else if (e.type == DioExceptionType.connectionTimeout) {
        throw TimeoutException(e.message);
      } else if (e.type == DioExceptionType.sendTimeout) {
        throw TimeoutException(e.message);
      } else if (e.response?.statusCode == 404) {
        throw NotFoundException(e.message);
      } else if (e.response?.statusCode == 409) {
        throw ConflictException(e.message);
      }
      throw RequestException();
    } on FormatException {
      throw RequestException();
    }
  }

  static Future<Uint8List> postCustom(
      {required Dio dio,
      required Uri uri,
      required Object? data,
      Options? options}) async {
    try {
      final query = uri.toString();
      log('REQUEST $query ===> Done');
      final response = await dio.post(
        query,
        data: data,
        options: options,
      );
      log('RESULT $query ===> ${response.data}');

      if (response.statusCode == 200) {
        return response.data!;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Request failed with status: ${response.statusCode}.',
        );
      }
    } on SocketException catch (e) {
      throw SocketException(e.message);
    } on TimeoutException catch (e) {
      throw TimeoutException(e.message);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        throw NoInternetException();
      } else if (e.response?.statusCode == 401) {
        throw UnauthorizedException();
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw TimeoutException(e.message);
      } else if (e.type == DioExceptionType.connectionTimeout) {
        throw TimeoutException(e.message);
      } else if (e.type == DioExceptionType.sendTimeout) {
        throw TimeoutException(e.message);
      } else if (e.response?.statusCode == 404) {
        throw NotFoundException(e.message);
      } else if (e.response?.statusCode == 409) {
        throw ConflictException(e.message);
      }
      throw RequestException();
    } on FormatException {
      throw RequestException();
    }
  }

/*
  static Future<Response> get2(Uri uri,
      {Map<String, String>? headers}) async {
    try {
      final response = await http
          .get(uri, headers: headers)
          .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        return response;
      } else {
        throw DioException(
          requestOptions: response.request.,
          response: response,
          type: DioExceptionType.response,
          error: 'Request failed with status: ${response.statusCode}.',
        );
      }
    } on SocketException catch (e) {
      throw SocketException(e.message);
    } on TimeoutException catch (e) {
      throw TimeoutException(e.message);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        throw NoInternetException();
      } else if (e.response?.statusCode == 401) {
        throw UnauthorizedException();
      }
      throw RequestException();
    } on FormatException {
      throw RequestException();
    }
  }*/
}
