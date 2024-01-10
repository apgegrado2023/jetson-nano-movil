class Constants {
  Constants({
    this.ipServer = '0.0.0.0',
  });

  String ipServer;
  static const int _portServer = 8765;
  static const String _token = 'IyK36JjZJMB3rPWJhEf5yGtd2y0214igkgJCNxDyxmY=';
  //static const String _token = 'mi_token_secreto';

  String get prototypeApi => 'ws://$ipServer:$portServer/$_token';

  int get portServer => _portServer;
  String get token => _token;
  Uri get url {
    return Uri(
      scheme: "ws",
      host: ipServer,
      port: portServer,
      path: '/$_token',
    );
  }

  Constants copyWith({
    String? ipServer,
  }) {
    return Constants(
      ipServer: ipServer ?? this.ipServer,
    );
  }
}

class Constantsv2 {
  static const String _networkPrefix = '192.168.3';
  static String? _ipServer = '0.0.0.0';
  static const int _portServer = 8765;
  static const String _token = 'IyK36JjZJMB3rPWJhEf5yGtd2y0214igkgJCNxDyxmY=';

  static String get ipServer => _ipServer!;
  static set ipServer(String? newIP) {
    _ipServer = newIP;
  }

  static int get portServer => _portServer;
  static String get networkPrefix => _networkPrefix;

  static Uri get url {
    return Uri(
      scheme: "ws",
      host: ipServer,
      port: portServer,
      path: '/$_token',
    );
  }
}
