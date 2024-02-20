import 'package:flutter_application_prgrado/domain/entities/user.dart';

class UserModel extends UserEntity {
  const UserModel({
    String? id,
    String? name,
    String? lastName,
    String? lastNameSecond,
    String? password,
    String? typeUser,
    String? userName,
    String? creatorId,
    DateTime? registrationDate,
    DateTime? updateDate,
    int? status,
  }) : super(
            id: id,
            name: name,
            lastName: lastName,
            lastNameSecond: lastNameSecond,
            password: password,
            typeUser: typeUser,
            userName: userName,
            creatorId: creatorId,
            registrationDate: registrationDate,
            updateDate: updateDate,
            status: status);

  /*UserModel.create(
      {required this.id,
      required this.name,
      required this.lastName,
      required this.lastNameSecond,
      required this.password,
      required String creatorId,
      required this.userName})
      : typeUser = 'driver',
        super.create(creatorId: creatorId);*/

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'last_name': lastName,
      'last_name_second': lastNameSecond,
      'type_user': typeUser,
      'password': password,
      'user_name': userName,
      'creator_id': creatorId,
      'registration_date': registrationDate.toString(),
      'update_date': updateDate.toString(),
      'status': status,
    };
  }

  factory UserModel.fromEntity(UserEntity user) {
    return UserModel(
      id: user.id,
      name: user.name,
      password: user.password,
      lastName: user.lastName,
      lastNameSecond: user.lastNameSecond,
      typeUser: user.typeUser,
      userName: user.userName,
      registrationDate: user.registrationDate,
      updateDate: user.updateDate,
      status: user.status,
      creatorId: user.creatorId,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic>? data) {
    return UserModel(
      id: data?['id'] ?? '',
      name: data?['name'] ?? '',
      password: data?['password'] ?? '',
      lastName: data?['last_name'] ?? '',
      lastNameSecond: data?['last_name_second'] ?? '',
      typeUser: data?['type_user'] ?? 'usuario normal',
      userName: data?['user_name'] ?? '',
      registrationDate: DateTime.parse(
          data?['registration_date'] ?? DateTime.now().toString()),
      updateDate:
          DateTime.parse(data?['update_date'] ?? DateTime.now().toString()),
      status: data?['status'] ?? -1,
      creatorId: data?['creator_id'] ?? '',
    );
  }
}
