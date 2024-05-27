import 'package:flutter_application_prgrado/data/data_sources/failures.dart';
import 'package:http/http.dart';

abstract class DataState<T> {
  final T? data;
  final Failure? failure;

  const DataState({this.data, this.failure});
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(Failure error) : super(failure: error);
}
