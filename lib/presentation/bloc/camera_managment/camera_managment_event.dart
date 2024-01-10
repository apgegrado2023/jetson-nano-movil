part of 'camera_managment_bloc.dart';

abstract class CameraManagmentEvent {
  const CameraManagmentEvent();
}

enum StateCameras { active, disable, none }

class OnConectCameras implements CameraManagmentEvent {
  final StateCameras stateCameras;

  const OnConectCameras(this.stateCameras);
}
