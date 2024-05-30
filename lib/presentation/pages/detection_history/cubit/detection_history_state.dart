part of 'detection_history_cubit.dart';

enum DetectHistoryDevice { initial, loading, success, error }

class DetectionHistoryState extends Equatable {
  final List<DetectionHistoryEntity> listMemberEntity;
  final List<DetectionHistoryEntity> listMemberEntityOriginal;
  final int index;
  final DetectHistoryDevice detectHistoryDevice;
  final StatusConnection statusConnection;

  const DetectionHistoryState({
    this.listMemberEntity = const [],
    this.listMemberEntityOriginal = const [],
    this.index = 0,
    this.detectHistoryDevice = DetectHistoryDevice.initial,
    this.statusConnection = StatusConnection.initial,
  });

  @override
  List<Object?> get props => [
        listMemberEntity,
        listMemberEntityOriginal,
        detectHistoryDevice,
        statusConnection,
        index,
      ];

  DetectionHistoryState copyWith({
    List<DetectionHistoryEntity>? listMemberEntity,
    List<DetectionHistoryEntity>? listMemberEntityOriginal,
    int? index,
    DetectHistoryDevice? detectHistoryDevice,
    StatusConnection? statusConnection,
  }) {
    return DetectionHistoryState(
      listMemberEntity: listMemberEntity ?? this.listMemberEntity,
      listMemberEntityOriginal:
          listMemberEntityOriginal ?? this.listMemberEntityOriginal,
      index: index ?? this.index,
      detectHistoryDevice: detectHistoryDevice ?? this.detectHistoryDevice,
      statusConnection: statusConnection ?? this.statusConnection,
    );
  }
}
