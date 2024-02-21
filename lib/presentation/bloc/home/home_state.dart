import 'package:equatable/equatable.dart';
import 'package:http/http.dart';

enum HomeStatus {
  loginStatusInitial,
  loginStatusLoading,
  loginStatusDone,
  loginStatusError
}

class HomeState {
  final int? index;

  final ClientException? error;

  const HomeState({
    this.index,
    this.error,
  });

  HomeState copyWith({
    int? index,
    ClientException? error,
  }) {
    return HomeState(
      index: index ?? this.index,
      error: error ?? this.error,
    );
  }
}
