import 'dart:convert';

import 'package:flutter_application_prgrado/data/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SessionService {
  Future<bool> saveToSession(UserModel user) async {
    try {
      const storage = FlutterSecureStorage();
      final userJson = user.toJson();
      String userJsonString = jsonEncode(userJson);
      await storage.write(key: 'user', value: userJsonString);
      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> removeToSession() async {
    try {
      const storage = FlutterSecureStorage();

      await storage.delete(key: 'user');
      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  Future<UserModel?> getToSession() async {
    const storage = FlutterSecureStorage();
    final userJson = await storage.read(key: 'user');
    if (userJson != null) {
      Map<String, dynamic> userMap = jsonDecode(userJson);
      return UserModel.fromJson(userMap);
    } else {
      return null;
    }
  }
}
