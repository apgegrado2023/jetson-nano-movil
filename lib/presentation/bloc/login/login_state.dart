import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

enum LoginStatus {
  loginStatusInitial,
  loginStatusLoading,
  loginStatusDone,
  loginStatusError
}

class LoginState {
  final String? email;
  final String? password;
  final DioException? error;

  const LoginState({
    this.email,
    this.password,
    this.error,
  });

  LoginState copyWith({
    String? email,
    String? password,
    DioException? error,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      error: error ?? this.error,
    );
  }
}
