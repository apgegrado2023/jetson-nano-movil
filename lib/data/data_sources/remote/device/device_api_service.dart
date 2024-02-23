import 'dart:async';
import 'dart:io';
import 'dart:convert' as convert;
import 'package:dio/dio.dart';
import 'package:flutter_application_prgrado/core/resources/http_state.dart';
import 'package:flutter_application_prgrado/data/data_sources/remote/service_base/http_response.dart';
import 'package:flutter_application_prgrado/data/data_sources/remote/service_base/service_api.dart';
import 'package:flutter_application_prgrado/data/models/prototype/information_system.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../../core/constants/constants.dart';

class DeviceApiService {
  final Dio dio;
  DeviceApiService(this.dio);

  Future<HttpServiceResponse<bool>> checkConnection() async {
    //try {
    final response =
        await ServiceApi.get(ApiBaseURL.pathSegments(['check_connection']));
    final httpResponse = HttpServiceResponse<bool>(true, response);
    return httpResponse;
    /* } catch (s) {
      return HttpServiceResponse(false, Response(s.toString(), 500));
    }*/
  }

  Future<HttpServiceResponse<SystemInfoModel?>> getSystemInfo() async {
    //try {
    final response = await ServiceApi.get(ApiBaseURL.pathSegments(['device']));
    if (response.statusCode == HttpStatus.ok) {
      var json = convert.jsonDecode(response.body) as Map<String, dynamic>;
      return HttpServiceResponse(SystemInfoModel.fromJson(json), response);
    }

    return HttpServiceResponse(null, response);
    /* } catch (s) {
      return HttpServiceResponse(null, Response(s.toString(), 500));
    }*/
  }

  Future<HttpState<SystemInfoModel>> getDSystemInfo() async {
    try {
      final response = await dio.getUri(
        ApiBaseURL.pathSegments(['device']),
      );
      if (response.statusCode == HttpStatus.ok) {
        var json = response.data;
        final httpResponse =
            HttpResponse(SystemInfoModel.fromJson(json), response);
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

  Future<HttpState<bool>> checkDConnection() async {
    try {
      final response =
          await dio.getUri(ApiBaseURL.pathSegments(['check_connection']));
      if (response.statusCode == HttpStatus.ok) {
        final httpResponse = HttpResponse(true, response);
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
}
