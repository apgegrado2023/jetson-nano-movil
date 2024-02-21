import 'dart:async';
import 'dart:io';
import 'dart:convert' as convert;
import 'package:flutter_application_prgrado/data/data_sources/remote/service_base/http_response.dart';
import 'package:flutter_application_prgrado/data/data_sources/remote/service_base/service_api.dart';
import 'package:flutter_application_prgrado/data/models/prototype/information_system.dart';
import 'package:http/http.dart';
import '../../../../../core/constants/constants.dart';

class DeviceApiService {
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
}
