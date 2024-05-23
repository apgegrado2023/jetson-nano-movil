part of 'information_device_bloc.dart';

class InformationDeviceState extends Equatable {
  final StorageInfoEntity? storageInfoEntity;
  final MemoryInfoEntity? memoryInfoEntity;
  final MemoryInfoSwapEntity? memoryInfoSwapEntity;
  final double? temperature;
  final double? cpuUsage;

  const InformationDeviceState({
    this.storageInfoEntity,
    this.memoryInfoEntity,
    this.memoryInfoSwapEntity,
    this.temperature,
    this.cpuUsage,
  });

  @override
  List<Object?> get props {
    return [
      storageInfoEntity,
      memoryInfoEntity,
      memoryInfoEntity,
      temperature,
      cpuUsage
    ];
  }
}

class InformationDeviceInitial extends InformationDeviceState {
  const InformationDeviceInitial();
}

class InformationDeviceLoading extends InformationDeviceState {
  const InformationDeviceLoading();
}

class InformationDeviceDisconnection extends InformationDeviceState {
  const InformationDeviceDisconnection() : super();
}

class InformationDeviceDone extends InformationDeviceState {
  const InformationDeviceDone({
    required final StorageInfoEntity storageInfoEntity,
    required final MemoryInfoEntity memoryInfoEntity,
    required final MemoryInfoSwapEntity memoryInfoSwapEntity,
    required final double temperature,
    required final double cpuUsage,
  }) : super(
          cpuUsage: cpuUsage,
          storageInfoEntity: storageInfoEntity,
          memoryInfoEntity: memoryInfoEntity,
          temperature: temperature,
          memoryInfoSwapEntity: memoryInfoSwapEntity,
        );
}
