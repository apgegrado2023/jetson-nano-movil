import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';

abstract class HttpState<T> {
  final HttpResponse<T>? httpResponse;
  final DioException? error;

  const HttpState({
    this.httpResponse,
    this.error,
  });
}

class HttpSuccess<T> extends HttpState<T> {
  const HttpSuccess(HttpResponse<T> httpResponse)
      : super(httpResponse: httpResponse);
}

class HttpFailed<T> extends HttpState<T> {
  const HttpFailed(DioException error) : super(error: error);
}
