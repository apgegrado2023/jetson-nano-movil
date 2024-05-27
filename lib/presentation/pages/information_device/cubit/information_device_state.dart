part of 'information_device_cubit.dart';

enum StatusInformationDevice { initial, loading, success, error }

enum StatusConnection { initial, disconnected, connected }

enum DialogState {
  none(1),
  success(2),
  info(3),
  error(4);

  const DialogState(this.id);

  final int id;
}

class InformationDeviceState extends Equatable {
  final StorageInfoEntity storageInfoEntity;
  final MemoryInfoEntity memoryInfoEntity;
  final MemoryInfoSwapEntity memoryInfoSwapEntity;
  final double temperature;
  final double cpuUsage;
  final StatusInformationDevice status;
  final StatusConnection statusConnection;

  final String messageNotification;
  final String titleNotification;
  final DialogState dialog;

  const InformationDeviceState({
    this.storageInfoEntity = const StorageInfoEntity.empty(),
    this.memoryInfoEntity = const MemoryInfoEntity.empty(),
    this.memoryInfoSwapEntity = const MemoryInfoSwapEntity.empty(),
    this.temperature = 0.0,
    this.cpuUsage = 0.0,
    this.titleNotification = '',
    this.messageNotification = '',
    this.status = StatusInformationDevice.initial,
    this.statusConnection = StatusConnection.initial,
    this.dialog = DialogState.none,
  });

  InformationDeviceState copyWith({
    StorageInfoEntity? storageInfoEntity,
    MemoryInfoEntity? memoryInfoEntity,
    MemoryInfoSwapEntity? memoryInfoSwapEntity,
    double? temperature,
    double? cpuUsage,
    StatusInformationDevice? status,
    StatusConnection? statusConnection,
    String? titleNotification,
    String? messageNotification,
    DialogState? dialog,
  }) {
    return InformationDeviceState(
      storageInfoEntity: storageInfoEntity ?? this.storageInfoEntity,
      memoryInfoEntity: memoryInfoEntity ?? this.memoryInfoEntity,
      memoryInfoSwapEntity: memoryInfoSwapEntity ?? this.memoryInfoSwapEntity,
      temperature: temperature ?? this.temperature,
      cpuUsage: cpuUsage ?? this.cpuUsage,
      status: status ?? this.status,
      statusConnection: statusConnection ?? this.statusConnection,
      messageNotification: messageNotification ?? this.messageNotification,
      titleNotification: titleNotification ?? this.titleNotification,
      dialog: dialog ?? this.dialog,
    );
  }

  @override
  List<Object?> get props {
    return [
      storageInfoEntity,
      memoryInfoEntity,
      memoryInfoSwapEntity,
      temperature,
      cpuUsage,
      statusConnection,
      status,
      titleNotification,
      messageNotification,
      dialog,
    ];
  }
}
