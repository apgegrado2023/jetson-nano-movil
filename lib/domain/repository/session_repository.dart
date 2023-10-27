import '../../data/models/user.dart';

abstract class SessionRepository {
  Future<void> saveToSession(User user);
  Future<void> removeToSession();
  Future<User?> getToSession();
}
