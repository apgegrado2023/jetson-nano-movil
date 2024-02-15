import 'package:flutter_application_prgrado/core/resources/data_state.dart';
import 'package:flutter_application_prgrado/domain/entities/user.dart';

abstract class SessionRepository {
  Future<DataState<bool>> saveToSession(UserEntity user);
  Future<DataState<bool>> removeToSession();
  Future<DataState<UserEntity>> getToSession();
}
