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
