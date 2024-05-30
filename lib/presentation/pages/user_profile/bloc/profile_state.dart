part of 'profile_bloc.dart';

class ProfileState {
  final String? password;
  final String? userName;
  final String? name;
  final String? lastName;
  final String? lastNameSecond;
  final UserEntity? userEntity;

  const ProfileState({
    this.password,
    this.userName,
    this.name,
    this.lastName,
    this.lastNameSecond,
    this.userEntity,
  });

  ProfileState copyWith({
    String? password,
    String? name,
    String? lastName,
    String? lastNameSecond,
    String? userName,
    UserEntity? userEntity,
  }) {
    return ProfileState(
      password: password ?? this.password,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      lastNameSecond: lastNameSecond ?? this.lastNameSecond,
      userName: userName ?? this.userName,
      userEntity: userEntity ?? this.userEntity,
    );
  }
}
