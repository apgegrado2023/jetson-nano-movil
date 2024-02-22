import 'package:dio/dio.dart';
import 'package:http/http.dart';

abstract class DataState<T> {
  final T? data;
  final ClientException? error;
  final DioException? dioException;
  final Exception? exception;

  const DataState({this.data, this.dioException, this.error, this.exception});
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(ClientException error) : super(error: error);
}

class DataFailed2<T> extends DataState<T> {
  const DataFailed2(DioException error) : super(dioException: error);
}

class DataError<T> extends DataState<T> {
  const DataError(Exception error) : super(exception: error);
}
