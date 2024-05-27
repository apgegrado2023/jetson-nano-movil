import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_application_prgrado/data/data_sources/exceptions.dart';
import 'package:http/http.dart' as http;

class ServiceApi {
  /*static Future<http.Response> get(Uri uri,
      {Map<String, String>? headers}) async {
    try {
      final response = await http
          .get(uri, headers: headers)
          .timeout(const Duration(seconds: 5))
          .onError((error, stackTrace) => http.Response(error.toString(), 404));
      return response;
    } catch (e) {
      print(e);
      return http.Response(e.toString(), 404);
    } finally {}
  }*/

  /*static Future<http.Response> get2(Uri uri,
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

  static Future<http.Response> post2(Uri uri, Object body) async {
    try {
      var response = await http.post(
        uri,
        body: jsonEncode(body),
        headers: {
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));

      return response;
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
  }

  /*static Future<http.Response> post(Uri uri, Object body) async {
    try {
      var response = await http
          .post(
            uri,
            body: jsonEncode(body),
            headers: {
              'Content-Type': 'application/json',
            },
          )
          .timeout(const Duration(seconds: 10))
          .onError((error, stackTrace) => http.Response(error.toString(), 404));
      return response;
    } catch (e) {
      return http.Response(e.toString(), 404);
    } finally {}
  }*/
}
