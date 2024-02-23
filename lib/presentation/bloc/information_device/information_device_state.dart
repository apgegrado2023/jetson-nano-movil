part of 'information_device_bloc.dart';

abstract class InformationDeviceState extends Equatable {
  final StorageInfoEntity? storageInfoEntity;
  final MemoryInfoEntity? memoryInfoEntity;
  final MemoryInfoSwapEntity? memoryInfoSwapEntity;
  final double? temperature;
  final double? cpuUsage;
  final ClientException? error;

  const InformationDeviceState({
    this.storageInfoEntity,
    this.memoryInfoEntity,
    this.memoryInfoSwapEntity,
    this.temperature,
    this.cpuUsage,
    this.error,
  });

  @override
  List<Object> get props => [];
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
