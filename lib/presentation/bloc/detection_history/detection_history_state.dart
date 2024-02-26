part of 'detection_history_bloc.dart';

abstract class DetectionHistoryState extends Equatable {
  final List<DetectionHistoryEntity>? listDetectionHistory;
  const DetectionHistoryState({this.listDetectionHistory});

  @override
  List<Object> get props => [];
}

class DetectionHistoryInitial extends DetectionHistoryState {}

class DetectionHistoryLoading extends DetectionHistoryState {}

class DetectionHistoryDisconnection extends DetectionHistoryState {
  const DetectionHistoryDisconnection() : super();
}

class DetectionHistoryDone extends DetectionHistoryState {
  const DetectionHistoryDone({
    required List<DetectionHistoryEntity>? listDetectionHistory,
  }) : super(
          listDetectionHistory: listDetectionHistory,
        );
}
