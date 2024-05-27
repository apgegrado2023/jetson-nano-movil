import 'package:equatable/equatable.dart';

class SystemInfoEntity extends Equatable {
  final double cpuTemperature;
  final StorageInfoEntity storageInfo;
  final double cpuUsage;
  final MemoryInfoEntity memoryInfo;
  final MemoryInfoSwapEntity memoryInfoSwap;

  const SystemInfoEntity({
    required this.cpuTemperature,
    required this.storageInfo,
    required this.cpuUsage,
    required this.memoryInfo,
    required this.memoryInfoSwap,
  });

  const SystemInfoEntity.empty()
      : cpuTemperature = 0,
        storageInfo = const StorageInfoEntity.empty(),
        cpuUsage = 0.0,
        memoryInfo = const MemoryInfoEntity.empty(),
        memoryInfoSwap = const MemoryInfoSwapEntity.empty();

  @override
  List<Object?> get props {
    return [
      cpuTemperature,
      storageInfo,
      cpuUsage,
      memoryInfo,
      memoryInfoSwap,
    ];
  }
}

class MemoryInfoEntity extends Equatable {
  final int total;
  final int available;
  final double percentUsed;

  const MemoryInfoEntity({
    required this.total,
    required this.available,
    required this.percentUsed,
  });

  // Constructor vacío
  const MemoryInfoEntity.empty()
      : total = 0,
        available = 0,
        percentUsed = 0.0;

  @override
  List<Object?> get props {
    return [
      total,
      available,
      percentUsed,
    ];
  }
}

class MemoryInfoSwapEntity extends Equatable {
  final int total;
  final int free;
  final int used;
  final double percentUsed;

  const MemoryInfoSwapEntity({
    required this.total,
    required this.free,
    required this.used,
    required this.percentUsed,
  });

  // Constructor vacío
  const MemoryInfoSwapEntity.empty()
      : total = 0,
        free = 0,
        used = 0,
        percentUsed = 0.0;

  @override
  List<Object?> get props {
    return [
      total,
      free,
      used,
      percentUsed,
    ];
  }
}

class StorageInfoEntity extends Equatable {
  final int total;
  final int free;
  final int used;
  final double percentUsed;

  const StorageInfoEntity({
    required this.total,
    required this.free,
    required this.used,
    required this.percentUsed,
  });

  // Constructor vacío
  const StorageInfoEntity.empty()
      : total = 0,
        free = 0,
        used = 0,
        percentUsed = 0.0;

  @override
  List<Object?> get props {
    return [
      total,
      free,
      used,
      percentUsed,
    ];
  }
}
