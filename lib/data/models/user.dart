import 'dart:convert';

import 'package:flutter_application_prgrado/data/models/model_base.dart';

abstract class ModelConvert<T> {
  Map<String, dynamic> toJson();
  T fromSnapshot(Map<String, dynamic> snapshot);
}

abstract class DropdownInfo<T> {
  T get value;
  String get tag;
}

class User extends ModelBase implements ModelConvert<User>, DropdownInfo<User> {
  String id;

  String name;

  String lastName;
  String lastNameSecond;

  String password;

  String typeUser;

  User({
    required this.id,
    required this.name,
    required this.lastName,
    required this.lastNameSecond,
    required this.typeUser,
    required this.password,
    required String creatorId,
    required DateTime registrationDate,
    required DateTime updateDate,
    required int status,
  }) : super(status, registrationDate, updateDate, creatorId);

  User.withDefaults()
      : id = '',
        name = '',
        lastName = '',
        lastNameSecond = '',
        password = '',
        typeUser = 'none',
        super.withDefaults();

  User.createStaffMember({
    required this.name,
    required this.lastName,
    required this.lastNameSecond,
    required this.typeUser,
    required this.password,
    required String creatorId,
  })  : id = '',
        super.create(creatorId: creatorId);

  User.createStudentMember({
    required this.name,
    required this.lastName,
    required this.lastNameSecond,
    required this.typeUser,
    required String creatorId,
  })  : id = '',
        password = '',
        super.create(creatorId: creatorId);

  String jsonString() {
    Map<String, dynamic> jsonData = toJson();

    String jsonString = jsonEncode(jsonData);
    return jsonString;
  }

  @override
  Map<String, dynamic> toJson() {
    final parentJson = super.toJson();
    return {
      ...parentJson,
      'id': id,
      'name': name,
      'lastName': lastName,
      'lastNameSecond': lastNameSecond,
      'typeUser': typeUser,
      'password': password
    };
  }

  @override
  String toString() {
    return 'ID: $id\n'
        'Nombre: $name\n'
        'Apellido: $lastName\n'
        'Segundo apellido: $lastNameSecond\n'
        'Tipo de usuario: $typeUser';
  }

  @override
  fromSnapshot(Map<String, dynamic>? data) => User.fromSnapshot(data);

  String get fullName => "$name $lastName $lastNameSecond";

  factory User.fromSnapshot(Map<String, dynamic>? data) {
    return User(
      id: data?['id'] ?? '',
      name: data?['name'] ?? '',
      password: data?['password'] ?? '',
      lastName: data?['lastName'] ?? '',
      lastNameSecond: data?['lastNameSecond'] ?? '',
      typeUser: data?['typeUser'] ?? 'usuario normal',
      registrationDate:
          (data?['registrationDate'] as DateTime? ?? DateTime.now()),
      updateDate: (data?['updateDate'] as DateTime? ?? DateTime.now()),
      status: data?['status'] ?? -1,
      creatorId: data?['creatorId'] ?? '',
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;

  @override
  // TODO: implement tag
  String get tag => '$name $lastName $lastNameSecond';

  @override
  // TODO: implement value
  User get value => this;
}
