import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_prgrado/core/resources/data_state.dart';
import 'package:flutter_application_prgrado/domain/entities/detection_history.dart';
import 'package:flutter_application_prgrado/domain/usecases/get_detection_history.dart';

part 'detection_history_event.dart';
part 'detection_history_state.dart';

class DetectionHistoryBloc
    extends Bloc<DetectionHistoryEvent, DetectionHistoryState> {
  final GetDetectionHistoryUseCase _detectionHistoryUseCase;
  DetectionHistoryBloc(this._detectionHistoryUseCase)
      : super(DetectionHistoryInitial()) {
    on<InitialEvent>((s, e) => init(s, e));
  }

  Future<void> init(
    InitialEvent event,
    Emitter<DetectionHistoryState> emit,
  ) async {
    final list = await _detectionHistoryUseCase();
    if (list is DataSuccess) {
      emit(DetectionHistoryDone(listDetectionHistory: list.data));
      print(list);
    } else {
      print(list.dioException);
    }
  }
}
