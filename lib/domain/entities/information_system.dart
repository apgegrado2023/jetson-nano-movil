import 'package:equatable/equatable.dart';

class SystemInfoEntity extends Equatable {
  final double? cpuTemperature;
  final StorageInfoEntity? storageInfo;
  final double? cpuUsage;
  final MemoryInfoEntity? memoryInfo;
  final MemoryInfoSwapEntity? memoryInfoSwap;

  const SystemInfoEntity({
    this.cpuTemperature,
    this.storageInfo,
    this.cpuUsage,
    this.memoryInfo,
    this.memoryInfoSwap,
  });

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
  final int? total;
  final int? available;
  final double? percentUsed;

  const MemoryInfoEntity({
    this.total,
    this.available,
    this.percentUsed,
  });

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
  final int? total;
  final int? free;
  final int? used;
  final double? percentUsed;

  const MemoryInfoSwapEntity({
    this.total,
    this.free,
    this.used,
    this.percentUsed,
  });

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
  final int? total;
  final int? free;
  final int? used;
  final double? percentUsed;

  const StorageInfoEntity({
    this.total,
    this.free,
    this.used,
    this.percentUsed,
  });

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
