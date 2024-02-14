import 'package:flutter_application_prgrado/domain/entities/information_system.dart';

class SystemInfoModel extends SystemInfoEntity {
  const SystemInfoModel({
    double? cpuTemperature,
    StorageInfoModel? storageInfo,
    double? cpuUsage,
    MemoryInfoModel? memoryInfo,
    MemoryInfoSwapModel? memoryInfoSwap,
  }) : super(
          cpuTemperature: cpuTemperature,
          storageInfo: storageInfo,
          cpuUsage: cpuUsage,
          memoryInfo: memoryInfo,
          memoryInfoSwap: memoryInfoSwap,
        );

  factory SystemInfoModel.fromJson(Map<String, dynamic> json) {
    return SystemInfoModel(
      cpuTemperature: json['cpu_temperature'],
      storageInfo: StorageInfoModel.fromJson(json['storage_info']),
      cpuUsage: json['cpu_usage'],
      memoryInfo: MemoryInfoModel.fromJson(json['memory_info']),
      memoryInfoSwap: MemoryInfoSwapModel.fromJson(json['memory_info_swap']),
    );
  }

  /* Map<String, dynamic> toJson() {
    return {
      'cpu_temperature': cpuTemperature,
      'storage_info': storageInfo.toJson(),
      'cpu_usage': cpuUsage,
      'memory_info': memoryInfo.toJson(),
      'memory_info_swap': memoryInfoSwap.toJson()
    };
  }*/

  /*String jsonString() {
    Map<String, dynamic> jsonData = toJson();

    String jsonString = jsonEncode(jsonData);
    return jsonString;
  }*/
}

class MemoryInfoModel extends MemoryInfoEntity {
  const MemoryInfoModel({
    required int total,
    required int available,
    required double percentUsed,
  }) : super(
          available: available,
          total: total,
          percentUsed: percentUsed,
        );

  factory MemoryInfoModel.fromJson(Map<String, dynamic> json) {
    return MemoryInfoModel(
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

class MemoryInfoSwapModel extends MemoryInfoSwapEntity {
  const MemoryInfoSwapModel({
    required int total,
    required int free,
    required int used,
    required double percentUsed,
  }) : super(
          free: free,
          used: used,
          total: total,
          percentUsed: percentUsed,
        );

  factory MemoryInfoSwapModel.fromJson(Map<String, dynamic> json) {
    return MemoryInfoSwapModel(
      total: json['total'],
      free: json['free'],
      used: json['used'],
      percentUsed: json['percent_used'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'free': free,
      'used': used,
      'percent_used': percentUsed,
    };
  }
}

class StorageInfoModel extends StorageInfoEntity {
  const StorageInfoModel({
    required int total,
    required int free,
    required int used,
  }) : super(
          total: total,
          free: free,
          used: used,
          percentUsed: (used / total) * 100,
        );

  factory StorageInfoModel.fromJson(Map<String, dynamic> json) {
    final int total = json['total_storage'];
    final int free = json['free_storage'];
    final int used = json['used_storage'];
    return StorageInfoModel(total: total, free: free, used: used);
  }

  Map<String, dynamic> toJson() {
    return {
      'total_storage': total,
      'free_storage': free,
      'used_storage': used,
    };
  }
}
