class RegisterState {
  final String? password;
  final String? userName;
  final String? name;
  final String? lastName;
  final String? lastNameSecond;

  const RegisterState({
    this.password,
    this.userName,
    this.name,
    this.lastName,
    this.lastNameSecond,
  });

  RegisterState copyWith({
    String? password,
    String? name,
    String? lastName,
    String? lastNameSecond,
    String? userName,
  }) {
    return RegisterState(
      password: password ?? this.password,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      lastNameSecond: lastNameSecond ?? this.lastNameSecond,
      userName: userName ?? this.userName,
    );
  }
}
