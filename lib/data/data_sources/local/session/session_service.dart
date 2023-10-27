import 'package:flutter_application_prgrado/data/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  //final UserRepository _userRepository = Get.find<UserRepository>();

  Future<void> saveToSession(User user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('id', user.id);
  }

  Future<void> removeToSession() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('id');
  }

  /* Future<User?> getToSession() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('id');
    if (id == null) return null;
    final user = await _userRepository.getById(id);
    return user;
  }*/
}
