import 'package:equatable/equatable.dart';

class DetectionHistoryEntity extends Equatable {
  final String? idDetection;
  final DateTime? registerDetection;
  final String? description;
  final String? idUser;
  final int? typeDetection;
  List<String>? listPath;

  DetectionHistoryEntity({
    this.listPath,
    this.idDetection,
    this.registerDetection,
    this.description,
    this.idUser,
    this.typeDetection,
  });

  set setListPath(List<String>? newPath) {
    listPath = newPath;
  }

  @override
  List<Object?> get props {
    return [
      idDetection,
      registerDetection,
      description,
      idUser,
      typeDetection,
    ];
  }
}
