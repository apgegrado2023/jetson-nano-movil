import 'package:http/http.dart' as http;

class HttpServiceResponse<T> {
  final T data;
  final http.Response response;

  HttpServiceResponse(this.data, this.response);
}
