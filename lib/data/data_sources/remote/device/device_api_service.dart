import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:convert' as convert;
import 'package:dio/dio.dart';
import 'package:flutter_application_prgrado/core/resources/http_state.dart';
import 'package:flutter_application_prgrado/data/data_sources/api_method.dart';
import 'package:flutter_application_prgrado/data/data_sources/remote/service_base/http_response.dart';
import 'package:flutter_application_prgrado/data/data_sources/remote/service_base/service_api.dart';
import 'package:flutter_application_prgrado/data/models/prototype/information_system.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../../core/constants/constants.dart';

class DeviceApiService {
  final Dio dio;
  DeviceApiService(this.dio);

  (Uri, Uri) getUriVideoCameras() {
    final uriCameraOne = ApiBaseURL.pathSegments(['video_feedOne']);
    final uriCameraTwo = ApiBaseURL.pathSegments(['video_feedTwo']);
    return (uriCameraOne, uriCameraTwo);
  }

  Future<bool> checkConnection({
    bool isSingle = false,
  }) async {
    try {
      if (isSingle) {
        await ApiMethod.get(
          dio: dio,
          uri: ApiBaseURL.pathSegments(
            ['check_connection_single'],
          ),
        );

        return true;
      } else {
        await ApiMethod.get(
          dio: dio,
          uri: ApiBaseURL.pathSegments(
            ['check_connection'],
          ),
        );

        return true;
      }
    } catch (s) {
      rethrow;
    }
  }

  Future<SystemInfoModel> getSystemInfo() async {
    try {
      final response = await ApiMethod.get(
        dio: dio,
        uri: ApiBaseURL.pathSegments(
          ['device'],
        ),
      );
      final json = jsonDecode(response);
      final result = SystemInfoModel.fromJson(json);

      return result;
    } catch (s) {
      rethrow;
    }
  }

  Future<SystemInfoModel> getDSystemInfo() async {
    try {
      final response = await ApiMethod.get(
        dio: dio,
        uri: ApiBaseURL.pathSegments(
          ['device'],
        ),
      );
      final json = jsonDecode(response);
      final result = SystemInfoModel.fromJson(json);

      return result;
    } catch (s) {
      rethrow;
    }
  }

  Future<bool> checkDConnection(bool isSingle) {
    return isSingle ? checkDConnectionSingle() : checkDConnectionSound();
  }

  Future<bool> checkDConnectionSound() async {
    try {
      await ApiMethod.get(
        dio: dio,
        uri: ApiBaseURL.pathSegments(
          ['check_connection'],
        ),
      );
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> checkDConnectionSingle() async {
    try {
      await ApiMethod.get(
        dio: dio,
        uri: ApiBaseURL.pathSegments(
          ['check_connection_single'],
        ),
      );
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
