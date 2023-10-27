import 'package:flutter_application_prgrado/data/models/user.dart';
import 'package:flutter_application_prgrado/domain/repository/session_repository.dart';
import 'package:flutter_application_prgrado/domain/repository/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionRepositoryImpl extends SessionRepository {
  final UserRepository _userRepository;

  SessionRepositoryImpl(this._userRepository);

  @override
  Future<void> saveToSession(User user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('id', user.id);
  }

  @override
  Future<void> removeToSession() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('id');
    //arfyiztgvoszusaj
  }

  @override
  Future<User?> getToSession() async {
    print("se llama a sesion");
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('id');
    if (id == null) return null;
    final user = await _userRepository.getById(id);
    return user;
  }
}
