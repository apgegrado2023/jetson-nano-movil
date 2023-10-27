import 'dart:convert';

class SystemInfo {
  double cpuTemperature;
  int totalStorage;
  double cpuUsage;
  MemoryInfo memoryInfo;

  SystemInfo({
    required this.cpuTemperature,
    required this.totalStorage,
    required this.cpuUsage,
    required this.memoryInfo,
  });

  factory SystemInfo.fromJson(Map<String, dynamic> json) {
    return SystemInfo(
      cpuTemperature: json['cpu_temperature'],
      totalStorage: json['total_storage'],
      cpuUsage: json['cpu_usage'],
      memoryInfo: MemoryInfo.fromJson(json['memory_info']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cpu_temperature': cpuTemperature,
      'total_storage': totalStorage,
      'cpu_usage': cpuUsage,
      'memory_info': memoryInfo.toJson(),
    };
  }

  String jsonString() {
    Map<String, dynamic> jsonData = toJson();

    String jsonString = jsonEncode(jsonData);
    return jsonString;
  }
}

class MemoryInfo {
  int total;
  int available;
  double percentUsed;

  MemoryInfo({
    required this.total,
    required this.available,
    required this.percentUsed,
  });

  factory MemoryInfo.fromJson(Map<String, dynamic> json) {
    return MemoryInfo(
      total: json['total'],
      available: json['available'],
      percentUsed: json['percent_used'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'available': available,
      'percent_used': percentUsed,
    };
  }
}
