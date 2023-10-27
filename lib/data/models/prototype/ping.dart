class Ping {
  final String type;
  final String response;

  Ping(this.type, this.response);

  // Método para convertir un objeto Ping a un mapa (JSON)
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'response': response,
    };
  }

  // Método para crear un objeto Ping a partir de un mapa (JSON)
  factory Ping.fromJson(Map<String, dynamic> json) {
    return Ping(
      json['type'] as String,
      json['response'] as String,
    );
  }
}
