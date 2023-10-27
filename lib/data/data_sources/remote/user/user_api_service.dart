/*import 'dart:math';

import 'package:flutter_application_prgrado/data/models/prototype/request.dart';
import 'package:flutter_application_prgrado/data/models/user.dart';

import '../../../../injection_container.dart';
import '../prototype/prototype_api_service.dart';

class UserApiService {
  PrototypApieService prototypApieService;

  Request? request;
  String generateUniqueCode() {
    final random = Random();
    final uniqueCode = random.nextInt(90000) + 10000;
    return uniqueCode.toString();
  }

  UserApiService(this.prototypApieService);
  Future<ResponseService?> insert(User user) async {
    try {
      request = Request.service(
        "service_database",
        Service(
          "POST",
          body: user.jsonString(),
        ),
        generateUniqueCode(),
      );

      final response = await prototypApieService.request(request!);

      return response;
    } catch (e) {
      return null;
    }
  }

  Future<ResponseService?> getById(String id) async {
    try {
      request = Request.service(
        "service_database",
        Service(
          "GET",
          body: ({"id": id}).toString(),
        ),
        generateUniqueCode(),
      );

      final response = await prototypApieService.request(request!);

      return response;
    } catch (e) {
      return null;
    }
  }

  Future<ResponseService?> getByParams(String userName, String password) async {
    //try {
    request = Request.service(
      "service_database",
      Service(
        "GET",
        body: ({"userName": userName, "password": password}).toString(),
      ),
      generateUniqueCode(),
    );

    final response = await prototypApieService.request(request!);
    print(response!.data);
    return response;
    /*} catch (e) {
      return null;
    }*/
  }
}
*/