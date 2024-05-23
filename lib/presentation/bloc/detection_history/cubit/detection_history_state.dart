part of 'detection_history_cubit.dart';

class DetectionHistoryState extends Equatable {
  final List<DetectionHistoryEntity>? listMemberEntity;
  final List<DetectionHistoryEntity>? listMemberEntityOriginal;
  final int? index;

  const DetectionHistoryState(
      {this.listMemberEntity, this.listMemberEntityOriginal, this.index});

  @override
  List<Object?> get props => [listMemberEntity, listMemberEntityOriginal];

  DetectionHistoryDone copyWithList(
      {List<DetectionHistoryEntity>? listMemberEntity,
      List<DetectionHistoryEntity>? listMemberEntityOriginal,
      int? index}) {
    return DetectionHistoryDone(
        listMemberEntity: listMemberEntity ?? this.listMemberEntity,
        listMemberEntityOriginal:
            listMemberEntityOriginal ?? this.listMemberEntityOriginal,
        index: index ?? this.index);
  }
}

class DetectionHistoryInitial extends DetectionHistoryState {}

class DetectionHistoryLoading extends DetectionHistoryState {}

class DetectionHistoryDisconnection extends DetectionHistoryState {
  const DetectionHistoryDisconnection() : super();
}

class DetectionHistoryDone extends DetectionHistoryState {
  const DetectionHistoryDone(
      {final List<DetectionHistoryEntity>? listMemberEntityOriginal,
      final List<DetectionHistoryEntity>? listMemberEntity,
      final int? index})
      : super(
            listMemberEntityOriginal: listMemberEntityOriginal,
            listMemberEntity: listMemberEntity,
            index: index);
}
