import 'dart:convert';

class RequestService {
  final String type;
  final String command;
  final Map<String, dynamic>? body;

  RequestService({required this.type, required this.command, this.body});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{
      'type': type,
      'command': command,
      'body': body
    };
    return data;
  }

  factory RequestService.fromJson(Map<String, dynamic> json) {
    final type = json['type'];
    final command = json['command'];
    final body = json['body'];

    return RequestService(
      command: command,
      type: type,
      body: body,
    );
  }

  String jsonString() {
    Map<String, dynamic> jsonData = toJson();

    String jsonString = jsonEncode(jsonData);
    return jsonString;
  }
}

enum StatusResponse { sucess, failed, problem }

class ResponseService {
  final StatusResponse responseStatus;
  final String command;
  final Map<String, dynamic>? data;

  ResponseService(this.responseStatus, this.command, this.data);

  Map<String, dynamic> toJson() {
    return {
      'response': convertStatusResponse(responseStatus),
      'command': command,
      'data': data
    };
  }

  String convertStatusResponse(StatusResponse statusResponse) {
    switch (statusResponse) {
      case StatusResponse.sucess:
        return 'success';
      case StatusResponse.failed:
        return 'failed';
      default:
        return 'problem';
    }
  }

  static StatusResponse convertStatusResponseRevert(String statusResponse) {
    switch (statusResponse) {
      case 'success':
        return StatusResponse.sucess;
      case 'failed':
        return StatusResponse.failed;
      default:
        return StatusResponse.problem;
    }
  }

  static ResponseService fromJson(Map<String, dynamic> json) {
    return ResponseService(
      convertStatusResponseRevert(json['response'] as String),
      json['command'] as String,
      json['data'] == null ? null : json['data'] as Map<String, dynamic>,
    );
  }
}
