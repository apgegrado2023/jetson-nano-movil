import 'dart:convert';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter_application_prgrado/data/data_sources/remote/prototype/prototype_api_service.dart';
import 'package:flutter_application_prgrado/data/models/prototype/request.dart';
import 'package:flutter_application_prgrado/data/models/user.dart';
import 'package:flutter_application_prgrado/domain/repository/user_repository.dart';
import 'package:flutter_application_prgrado/injection_container.dart';

class UserRepositoryImpl extends UserRepository {
  final PrototypApieService prototypApieService;

  UserRepositoryImpl(this.prototypApieService);

  // Método para generar un código único de 5 dígitos
  String generateUniqueCode() {
    final random = Random();
    final uniqueCode = random.nextInt(90000) + 10000;
    return uniqueCode.toString();
  }

  @override
  Future<bool> insert(User user) async {
    try {
      final uniqueCode = generateUniqueCode();
      final request = RequestService(
        type: "service_database_user_insert",
        command: uniqueCode,
        body: user.toJson(),
      );

      final response = await prototypApieService.request(request);

      if (response != null) {
        final data = response.data;
        // Procesa los datos de respuesta según tus necesidades
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // Maneja la excepción adecuadamente
      return false;
    }
  }

  @override
  Future<User?> getById(String id) async {
    try {
      final uniqueCode = generateUniqueCode();
      final request = RequestService(
        type: "service_database_user_getById",
        body: {"id": id},
        command: uniqueCode,
      );

      final response = await prototypApieService.request(request);

      if (response.responseStatus == StatusResponse.failed) {
        return null;
      }
      final user = User.fromSnapshot(response.data);
      print(user.fullName);
      return user;
    } catch (e) {
      // Maneja la excepción adecuadamente
      return null;
    }
  }

  Map<String, dynamic> toJson(String userName, String password) {
    return {'userName': userName, 'password': password};
  }

  @override
  Future<User?> getByParams(String userName, String password) async {
    try {
      final uniqueCode = generateUniqueCode();
      final request = RequestService(
        type: "service_database_user_get_params",
        body: {'userName': userName, 'password': password},
        command: uniqueCode,
      );

      final response = await prototypApieService.request(request);

      if (response.responseStatus == StatusResponse.failed) {
        return null;
      }
      final user = User.fromSnapshot(response.data);
      print(user.fullName);
      return user;
    } catch (e) {
      return null;
    }
  }
}
