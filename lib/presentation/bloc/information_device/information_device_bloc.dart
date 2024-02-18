import 'dart:async';

import 'package:flutter_application_prgrado/core/resources/data_state.dart';
import 'package:flutter_application_prgrado/domain/entities/information_system.dart';
import 'package:flutter_application_prgrado/domain/usecases/get_information_device.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'information_device_event.dart';
part 'information_device_state.dart';

class InformationDeviceBloc
    extends Bloc<InformationDeviceEvent, InformationDeviceState> {
  final GetInformationDeviceUseCase _getInformationDeviceUseCase;
  bool _timerStarted = false;
  Timer? timer;
  StreamController<SystemInfoEntity> streamControllerSystem =
      StreamController<SystemInfoEntity>.broadcast();

  InformationDeviceBloc(this._getInformationDeviceUseCase)
      : super(InformationDeviceInitial()) {
    on<InitialEvent>(init);
  }

  Future<void> init(
    InitialEvent event,
    Emitter<InformationDeviceState> emit,
  ) async {
    //print("si funciona el");
  }

  Stream<SystemInfoEntity> obtenerDatos() {
    timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      final httpResponse = await _getInformationDeviceUseCase();
      if (httpResponse is DataSuccess) {
        streamControllerSystem.sink.add(httpResponse.data!);
      }
    });
    return streamControllerSystem.stream;
  }

  @override
  Future<void> close() {
    print("se cierra");
    timer?.cancel();
    streamControllerSystem.close();
    return super.close();
  }
}
