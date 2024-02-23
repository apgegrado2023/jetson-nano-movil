part of 'information_device_bloc.dart';

abstract class InformationDeviceEvent {}

class InitialEvent extends InformationDeviceEvent {}

class ChangeData extends InformationDeviceEvent {
  final SystemInfoEntity systemInfoEntity;

  ChangeData(this.systemInfoEntity);
}

class DisconnectionEvent extends InformationDeviceEvent {
  DisconnectionEvent();
}
