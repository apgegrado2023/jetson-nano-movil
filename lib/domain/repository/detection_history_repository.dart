import 'package:flutter_application_prgrado/core/resources/data_state.dart';
import 'package:flutter_application_prgrado/domain/entities/detection_history.dart';

abstract class DetectionHistoryRepository {
  Future<DataState<List<DetectionHistoryEntity>>> getDetectionHistory();
  Future<DataState<bool>> getImageUrl(List<String> listNameFile);
}
