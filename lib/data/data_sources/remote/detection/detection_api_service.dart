import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter_application_prgrado/core/resources/http_state.dart';
import 'package:flutter_application_prgrado/data/models/detection_history.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../../core/constants/constants.dart';

class DetectionApiService {
  final Dio dio;
  DetectionApiService(this.dio);

  Future<HttpState<List<DetectionHistoryModel>>> getDetectionHistory() async {
    try {
      final response = await dio.getUri(
        ApiBaseURL.pathSegments(['detection_history']),
      );
      if (response.statusCode == HttpStatus.ok) {
        var json = response.data;

        List<dynamic> dataList = json;
        List<DetectionHistoryModel> detectionHistory = [];

        for (var item in dataList) {
          var s = DetectionHistoryModel.fromJson(item);
          detectionHistory.add(s);
        }

        final httpResponse = HttpResponse(detectionHistory, response);
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

  Future<HttpState<Uint8List>> getImagesZip(List<String> listNameFile) async {
    try {
      final response = await dio.postUri(
        ApiBaseURL.pathSegments(['get_zip_images']),
        data: {'list_name_file': listNameFile},
        options: Options(responseType: ResponseType.bytes),
      );
      if (response.statusCode == HttpStatus.ok) {
        final Uint8List zipBytes = response.data!;

        final httpResponse = HttpResponse(zipBytes, response);
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
}
