import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

enum HomeStatus {
  loginStatusInitial,
  loginStatusLoading,
  loginStatusDone,
  loginStatusError
}

class HomeState {
  final int? index;

  final DioException? error;

  const HomeState({
    this.index,
    this.error,
  });

  HomeState copyWith({
    int? index,
    DioException? error,
  }) {
    return HomeState(
      index: index ?? this.index,
      error: error ?? this.error,
    );
  }
}
