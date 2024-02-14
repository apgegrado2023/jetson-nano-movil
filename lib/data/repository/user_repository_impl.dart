import 'dart:math';
import 'package:flutter_application_prgrado/data/data_sources/remote/prototype/data_source_prototype_service.dart';
import 'package:flutter_application_prgrado/data/data_sources/remote/prototype/prototype_api_service.dart';
import 'package:flutter_application_prgrado/data/models/prototype/request.dart';
import 'package:flutter_application_prgrado/data/models/user.dart';
import 'package:flutter_application_prgrado/domain/repository/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  //final PrototypApieService prototypApieService;
  //final DataSourcePrototypeService dataSourcePrototypeService;

  UserRepositoryImpl(
      //this.prototypApieService,
      // this.dataSourcePrototypeService,
      );

  // Método para generar un código único de 5 dígitos
  String generateUniqueCode() {
    final random = Random();
    final uniqueCode = random.nextInt(90000) + 10000;
    return uniqueCode.toString();
  }

  @override
  Future<bool> insert(User user) async {
    /*/*try {*/
    print("se llama al registrar");
    final uniqueCode = generateUniqueCode();
    final request = RequestService(
      type: "service_database_user_insert",
      command: uniqueCode,
      body: user.toJson(),
    );

    final response = await dataSourcePrototypeService.request(request);

    if (response.responseStatus == StatusResponse.failed) {
      return false;
    } else if (response.responseStatus == StatusResponse.problem) {
      return false;
    } else {
      return true;
    }
    /*} catch (e) {
      // Maneja la excepción adecuadamente
      return false;
    }*/*/
    return false;
  }

  @override
  Future<User?> getById(String id) async {
    /*try {
      final uniqueCode = generateUniqueCode();
      final request = RequestService(
        type: "service_database_user_getById",
        body: {"id": id},
        command: uniqueCode,
      );

      final response = await dataSourcePrototypeService.request(request);

      if (response.responseStatus == StatusResponse.failed) {
        return null;
      }
      final user = User.fromSnapshot(response.data);
      print(user.fullName);
      return user;
    } catch (e) {
      // Maneja la excepción adecuadamente
      return null;
    }*/
  }

  Map<String, dynamic> toJson(String userName, String password) {
    return {'userName': userName, 'password': password};
  }

  @override
  Future<User?> getByParams(String userName, String password) async {
    /*try {
      final uniqueCode = generateUniqueCode();
      final request = RequestService(
        type: "service_database_user_get_params",
        body: {'userName': userName, 'password': password},
        command: uniqueCode,
      );

      final response = await dataSourcePrototypeService.request(request);

      if (response.responseStatus == StatusResponse.failed) {
        return null;
      }
      final user = User.fromSnapshot(response.data);
      print(user.fullName);
      return user;
    } catch (e) {
      return null;
    }
  }*/
  }
}
