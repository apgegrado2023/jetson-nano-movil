import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? id;
  final String? name;
  final String? lastName;
  final String? lastNameSecond;
  final String? password;
  final String? typeUser;
  final String? userName;
  final String? creatorId;
  final DateTime? registrationDate;
  final DateTime? updateDate;
  final int? status;
  String get fullName => "$name $lastName $lastNameSecond";
  const UserEntity(
      {this.id,
      this.name,
      this.lastName,
      this.lastNameSecond,
      this.password,
      this.typeUser,
      this.userName,
      this.creatorId,
      this.registrationDate,
      this.updateDate,
      this.status});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
