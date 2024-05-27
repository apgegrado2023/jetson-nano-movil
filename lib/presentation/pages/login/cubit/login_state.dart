part of 'login_cubit.dart';

enum LoginStatus {
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

class LoginState extends Equatable {
  final String email;
  final String password;
  final LoginStatus status;

  final UserEntity userEntity;

  final LoadingDialog loadingDialog;
  final String messageDialogLoading;

  final DialogShow dialogShow;
  final DialogData dialogData;

  LoginState({
    this.email = '',
    this.password = '',
    this.messageDialogLoading = '',
    this.dialogData = const DialogData.empty(),
    this.status = LoginStatus.initial,
    this.dialogShow = DialogShow.none,
    this.loadingDialog = LoadingDialog.close,
    this.userEntity = const UserEntity.empty(),
  });

  LoginState copyWith({
    String? email,
    String? password,
    String? messageDialogLoading,
    LoginStatus? status,
    DialogShow? dialogShow,
    DialogData? dialogData,
    LoadingDialog? loadingDialog,
    UserEntity? userEntity,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      messageDialogLoading: messageDialogLoading ?? this.messageDialogLoading,
      dialogShow: dialogShow ?? this.dialogShow,
      dialogData: dialogData ?? this.dialogData,
      loadingDialog: loadingDialog ?? this.loadingDialog,
      userEntity: userEntity ?? this.userEntity,
    );
  }

  @override
  List<Object?> get props => [
        email,
        password,
        status,
        messageDialogLoading,
        dialogShow,
        dialogData,
        loadingDialog,
        userEntity,
      ];
}
