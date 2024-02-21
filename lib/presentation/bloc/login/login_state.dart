import 'package:equatable/equatable.dart';
import 'package:http/http.dart';

enum LoginStatus {
  loginStatusInitial,
  loginStatusLoading,
  loginStatusDone,
  loginStatusError
}

class LoginState {
  final String? email;
  final String? password;
  final ClientException? error;

  const LoginState({
    this.email,
    this.password,
    this.error,
  });

  LoginState copyWith({
    String? email,
    String? password,
    ClientException? error,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      error: error ?? this.error,
    );
  }
}
