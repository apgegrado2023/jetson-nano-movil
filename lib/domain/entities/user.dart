import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String name;
  final String lastName;
  final String lastNameSecond;
  final String password;
  final String typeUser;
  final String userName;
  final String creatorId;
  final DateTime? registrationDate;
  final DateTime? updateDate;
  final int status;
  String get fullName => "$name $lastName $lastNameSecond";
  UserEntity({
    required this.id,
    required this.name,
    required this.lastName,
    required this.lastNameSecond,
    required this.password,
    required this.typeUser,
    required this.userName,
    required this.creatorId,
    required this.registrationDate,
    required this.updateDate,
    required this.status,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        lastName,
        lastNameSecond,
        password,
        typeUser,
        userName,
        creatorId,
        status
      ];
  const UserEntity.empty()
      : id = '',
        name = '',
        lastName = '',
        lastNameSecond = '',
        password = '',
        typeUser = '',
        userName = '',
        creatorId = '',
        registrationDate = null,
        updateDate = null,
        status = 0;
}
