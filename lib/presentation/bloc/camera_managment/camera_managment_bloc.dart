import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'camera_managment_event.dart';
part 'camera_managment_state.dart';

class CameraManagmentBloc
    extends Bloc<CameraManagmentEvent, CameraManagmentState> {
  CameraManagmentBloc() : super(CameraManagmentInitial()) {
    on<OnConectCameras>((event, emit) => _onConectCameras(event, emit));
  }

  void _onConectCameras(
    OnConectCameras event,
    Emitter<CameraManagmentState> emit,
  ) {}
}
