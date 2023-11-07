import 'dart:convert';

class SystemInfo {
  double cpuTemperature;
  StorageInfo storageInfo;
  double cpuUsage;
  MemoryInfo memoryInfo;

  SystemInfo({
    required this.cpuTemperature,
    required this.storageInfo,
    required this.cpuUsage,
    required this.memoryInfo,
  });

  factory SystemInfo.fromJson(Map<String, dynamic> json) {
    return SystemInfo(
      cpuTemperature: json['cpu_temperature'],
      storageInfo: StorageInfo.fromJson(json['storage_info']),
      cpuUsage: json['cpu_usage'],
      memoryInfo: MemoryInfo.fromJson(json['memory_info']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cpu_temperature': cpuTemperature,
      'storage_info': storageInfo.toJson(),
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

class StorageInfo {
  int total;
  int free;
  int used;
  double percentUsed;

  StorageInfo({
    required this.total,
    required this.free,
    required this.used,
  }) : percentUsed = (used / total) * 100;

  factory StorageInfo.fromJson(Map<String, dynamic> json) {
    final total = json['total_storage'];
    final free = json['free_storage'];
    final used = json['used_storage'];
    return StorageInfo(total: total, free: free, used: used);
  }

  Map<String, dynamic> toJson() {
    return {
      'total_storage': total,
      'free_storage': free,
      'used_storage': used,
    };
  }
}
