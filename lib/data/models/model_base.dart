class ModelBase {
  final int status;
  final DateTime registrationDate;
  final DateTime dateUpdate;
  final String creatorId;

  ModelBase(
      this.status, this.registrationDate, this.dateUpdate, this.creatorId);
  convertDate(DateTime date) {
    return DateTime(
      date.year,
      date.month,
      date.day,
    );
  }

  ModelBase.withDefaults()
      : status = 0,
        registrationDate = DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day),
        dateUpdate = DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day),
        creatorId = '';
  ModelBase.create({required this.creatorId})
      : registrationDate = DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day),
        dateUpdate = DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day),
        status = 1;

  ModelBase fromSnapshot(Map<String, dynamic> data) {
    return ModelBase(
      data['status'] as int,
      (data['registrationDate'] as DateTime? ?? DateTime.now()),
      (data['dateUpdate'] as DateTime? ?? DateTime.now()),
      data['creatorId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'registrationDate': registrationDate,
      'dateUpdate': dateUpdate,
      'creatorId': creatorId,
    };
  }
}

class MyClass {
  late int status;
  late DateTime registrationDate;
  late DateTime dateUpdate;
  late int employeeId;
}
