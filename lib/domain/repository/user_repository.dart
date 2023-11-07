import 'package:flutter_application_prgrado/data/models/user.dart';

abstract class UserRepository {
  Future<bool> insert(User user);

  Future<User?> getById(String id);

  Future<User?> getByParams(String userName, String password);
}
