import 'dart:io';

import 'package:flutter_application_prgrado/core/resources/data_state.dart';
import 'package:flutter_application_prgrado/data/data_sources/local/session/session_service.dart';
import 'package:flutter_application_prgrado/data/data_sources/remote/user/user_api_service.dart';
import 'package:flutter_application_prgrado/data/models/user.dart';
import 'package:flutter_application_prgrado/domain/entities/user.dart';
import 'package:flutter_application_prgrado/domain/repository/session_repository.dart';
import 'package:flutter_application_prgrado/domain/repository/user_repository.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionRepositoryImpl extends SessionRepository {
  final SessionService _sessionService;

  SessionRepositoryImpl(this._sessionService);

  @override
  Future<DataState<bool>> saveToSession(UserEntity user) async {
    try {
      final prefs =
          await _sessionService.saveToSession(UserModel.fromEntity(user));

      return DataSuccess(prefs);
    } on Exception catch (e) {
      return DataError(e);
    }
  }

  @override
  Future<DataState<bool>> removeToSession() async {
    try {
      final prefs = await _sessionService.removeToSession();

      return DataSuccess(prefs);
    } on Exception catch (e) {
      return DataError(e);
    }
  }

  @override
  Future<DataState<UserEntity>> getToSession() async {
    try {
      final prefs = await _sessionService.getToSession();

      if (prefs == null) return DataError(Exception('No saved session'));

      return DataSuccess(prefs);
    } on Exception catch (e) {
      return DataError(e);
    }
  }
}
