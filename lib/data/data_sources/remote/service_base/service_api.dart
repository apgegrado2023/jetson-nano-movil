import 'dart:convert';

import 'package:http/http.dart' as http;

class ServiceApi {
  static Future<http.Response> get(Uri uri,
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
  }

  static Future<http.Response> post(Uri uri, Object body) async {
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
  }
}