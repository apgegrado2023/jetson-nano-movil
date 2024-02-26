import 'package:flutter_application_prgrado/core/resources/data_state.dart';
import 'package:flutter_application_prgrado/core/usecase/usecase.dart';
import 'package:flutter_application_prgrado/domain/entities/detection_history.dart';
import 'package:flutter_application_prgrado/domain/repository/detection_history_repository.dart';

class GetDetectionHistoryUseCase
    implements UseCaseFuture<DataState<List<DetectionHistoryEntity>>, void> {
  final DetectionHistoryRepository _detectionHistoryRepository;

  GetDetectionHistoryUseCase(this._detectionHistoryRepository);

  @override
  Future<DataState<List<DetectionHistoryEntity>>> call({void params}) {
    return _detectionHistoryRepository.getDetectionHistory();
  }
}
