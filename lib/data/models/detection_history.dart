import 'package:flutter_application_prgrado/domain/entities/detection_history.dart';

class DetectionHistoryModel extends DetectionHistoryEntity {
  DetectionHistoryModel(
      {String? idDetection,
      DateTime? registerDetection,
      String? description,
      String? idUser,
      int? typeDetection,
      List<String>? listPath})
      : super(
          listPath: listPath,
          idDetection: idDetection,
          registerDetection: registerDetection,
          description: description,
          idUser: idUser,
          typeDetection: typeDetection,
        );

  DateTime convertDate(Map<String, dynamic> json) {
    try {
      final dateTime = DateTime.parse(
          json['register_detection'] ?? DateTime.now().toString());
      return dateTime;
    } catch (e) {
      return DateTime.now();
    }
  }

  factory DetectionHistoryModel.fromJson(Map<String, dynamic> json) {
    DateTime convertDate(Map<String, dynamic> json) {
      try {
        final dateTime = DateTime.parse(
            json['register_detection'] ?? DateTime.now().toString());
        return dateTime;
      } catch (e) {
        return DateTime.now();
      }
    }

    return DetectionHistoryModel(
        idDetection: json['id_detection'],
        registerDetection: convertDate(json),
        description: json['description'],
        idUser: json['id_user'].toString(),
        typeDetection: json['type_detection'],
        listPath: (json['url_img_detection'] as List<dynamic>).cast<String>());
  }
}
