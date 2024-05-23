/*import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_prgrado/core/resources/data_state.dart';
import 'package:flutter_application_prgrado/domain/entities/detection_history.dart';
import 'package:flutter_application_prgrado/domain/usecases/get_detection_history.dart';

import '../../../domain/usecases/check_connection.dart';
import '../session/bloc/session_bloc.dart';
import '../session/bloc/session_event.dart';

part 'detection_history_event.dart';
part 'detection_history_state.dart';

class DetectionHistoryBloc
    extends Bloc<DetectionHistoryEvent, DetectionHistoryState> {
  final GetDetectionHistoryUseCase _detectionHistoryUseCase;
  final CheckConnectionUseCase _checkConnectionUseCase;
  DetectionHistoryBloc(this._detectionHistoryUseCase,
      this._checkConnectionUseCase, this.sessionBloc)
      : super(DetectionHistoryInitial()) {
    on<InitialEvent>(init);
    on<ChangeData>(onChangeData);
    on<DisconnectionEvent>(onDisconnection);
  }
  bool _timerStarted = false;
  final SessionBloc sessionBloc;
  Future<void> init(
    InitialEvent event,
    Emitter<DetectionHistoryState> emit,
  ) async {
    await getInfoDetectionHistory();
    verificationConnection();
  }

  Future<void> getInfoDetectionHistory() async {
    final httpResponse = await _detectionHistoryUseCase();
    if (httpResponse is DataSuccess) {
      add(ChangeData(httpResponse.data!));
    } else {
      add(DisconnectionEvent());
    }
  }

  void onChangeData(
    ChangeData event_,
    Emitter<DetectionHistoryState> emit,
  ) {
    final event = event_.list;
    emit(DetectionHistoryDone(listDetectionHistory: event));
  }

  void onDisconnection(
    DisconnectionEvent event_,
    Emitter<DetectionHistoryState> emit,
  ) {
    emit(DetectionHistoryDisconnection());
  }

  Future<void> verificationConnection() async {
    print('metodo verification iniciado');
    _timerStarted = true;
    while (_timerStarted) {
      final httpResponse = await _checkConnectionUseCase(true);
      if (httpResponse is DataSuccess) {
        sessionBloc.add(ConnectedSessionEvent(true));
        print('conectado');
        if (state is DetectionHistoryDisconnection) {
          print('actualizando lista');
          await getInfoDetectionHistory();
        }
      } else {
        sessionBloc.add(ConnectedSessionEvent(false));
        add(DisconnectionEvent());
      }
      await Future.delayed(Duration(seconds: 8));
    }
  }

  @override
  Future<void> close() {
    print("se cierra");
    _timerStarted = false;
    return super.close();
  }
}
*/