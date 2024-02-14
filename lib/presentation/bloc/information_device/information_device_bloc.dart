import 'package:flutter_bloc/flutter_bloc.dart';

part 'information_device_event.dart';
part 'information_device_state.dart';

class InformationDeviceBloc
    extends Bloc<InformationDeviceEvent, InformationDeviceState> {
  InformationDeviceBloc() : super(InformationDeviceInitial()) {
    on<InitialEvent>(init);
  }

  Future<void> init(
    InitialEvent event,
    Emitter<InformationDeviceState> emit,
  ) async {
    print("si funciona el");
  }
}
