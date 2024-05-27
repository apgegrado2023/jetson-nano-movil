part of 'register_cubit.dart';

enum RegisterStatus {
  initial,
  loading,
  success,
  error,
  warning,
}

enum LoadingDialog {
  open,
  close,
}

enum DialogShow {
  none,
  success,
  error,
  warning,
}

class RegisterState extends Equatable {
  final String password;
  final String userName;
  final String name;
  final String lastName;
  final String lastNameSecond;

  final UserEntity user;

  final RegisterStatus status;

  final LoadingDialog loadingDialog;
  final String messageDialogLoading;

  final DialogShow dialogShow;
  final DialogData dialogData;

  const RegisterState({
    this.password = '',
    this.userName = '',
    this.name = '',
    this.lastName = '',
    this.lastNameSecond = '',
    this.user = const UserEntity.empty(),
    this.dialogData = const DialogData.empty(),
    this.status = RegisterStatus.initial,
    this.dialogShow = DialogShow.none,
    this.loadingDialog = LoadingDialog.close,
    this.messageDialogLoading = '',
  });

  RegisterState copyWith({
    String? password,
    String? name,
    String? lastName,
    String? lastNameSecond,
    String? userName,
    UserEntity? user,
    String? messageDialogLoading,
    RegisterStatus? status,
    DialogShow? dialogShow,
    DialogData? dialogData,
    LoadingDialog? loadingDialog,
  }) {
    return RegisterState(
      password: password ?? this.password,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      lastNameSecond: lastNameSecond ?? this.lastNameSecond,
      userName: userName ?? this.userName,
      status: status ?? this.status,
      messageDialogLoading: messageDialogLoading ?? this.messageDialogLoading,
      dialogShow: dialogShow ?? this.dialogShow,
      dialogData: dialogData ?? this.dialogData,
      loadingDialog: loadingDialog ?? this.loadingDialog,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [
        password,
        name,
        lastName,
        lastNameSecond,
        user,
        userName,
        status,
        messageDialogLoading,
        dialogShow,
        dialogData,
        loadingDialog,
      ];
}
