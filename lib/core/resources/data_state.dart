import 'package:dio/dio.dart';
import 'package:http/http.dart';

abstract class DataState<T> {
  final T? data;
  final DioException? error;
  final ClientException? error2;

  const DataState({this.data, this.error, this.error2});
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(DioException error) : super(error: error);
}

class DataFailed2<T> extends DataState<T> {
  const DataFailed2(ClientException error) : super(error2: error);
}
