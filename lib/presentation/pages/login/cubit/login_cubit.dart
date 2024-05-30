import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_prgrado/config/utils/input_validators.dart';
import 'package:flutter_application_prgrado/core/resources/data_state.dart';
import 'package:flutter_application_prgrado/data/data_sources/failures.dart';
import 'package:flutter_application_prgrado/data/models/warning_dialog_data.dart';
import 'package:flutter_application_prgrado/domain/entities/user.dart';
import 'package:flutter_application_prgrado/domain/usecases/login.dart';
import 'package:flutter_application_prgrado/domain/usecases/save_session.dart';
import 'package:flutter_application_prgrado/presentation/session/bloc/session_bloc.dart';
import 'package:flutter_application_prgrado/presentation/widgets/dialogs/dialogs.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(
    this._saveSessionUseCase,
    this._loginUseCase,
  ) : super(LoginState());

  final SaveSessionUseCase _saveSessionUseCase;
  final LoginUseCase _loginUseCase;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void onEmailChanged(String email) {
    emit(state.copyWith(email: email));
  }

  void onPasswordChanged(String password) {
    emit(state.copyWith(password: password));
  }

  void onChangeDialog(DialogShow dialogShow) {
    emit(state.copyWith(dialogShow: dialogShow));
  }

  Future<void> onLoginSubmitted() async {
    if (!isFormValid()) return;

    emit(state.copyWith(
      status: LoginStatus.loading,
      loadingDialog: LoadingDialog.open,
      messageDialogLoading: 'Iniciando sesión...',
    ));

    final email = state.email;
    final password = state.password;

    final response = await submit(password, email);

    if (response is DataSuccess) {
      saveSession(response.data!);
      emit(state.copyWith(
        status: LoginStatus.success,
        loadingDialog: LoadingDialog.close,
        userEntity: response.data,
      ));
    } else if (response is DataFailed) {
      if (response.failure is NoInternetFailure) {
        emit(state.copyWith(
          loadingDialog: LoadingDialog.close,
          status: LoginStatus.error,
          dialogShow: DialogShow.error,
          dialogData: DialogData(
            message: 'No estas conectado a internet',
            title: 'Sin conexión',
            textButton: 'Cerrrar',
            onPressed: () {
              onChangeDialog(DialogShow.none);
              Dialogs.close();
            },
            barrierDismissible: false,
          ),
        ));
      } else if (response.failure is NotFoundFailure) {
        emit(state.copyWith(
          loadingDialog: LoadingDialog.close,
          status: LoginStatus.warning,
          dialogShow: DialogShow.warning,
          dialogData: DialogData(
            message: 'No se encontro el usuario, registre un nuevo usuario',
            title: 'No existe el usuario',
            textButton: 'Cerrrar',
            onPressed: () {
              onChangeDialog(DialogShow.none);
              Dialogs.close();
            },
            barrierDismissible: false,
          ),
        ));
      } else {
        emit(state.copyWith(
          loadingDialog: LoadingDialog.close,
          status: LoginStatus.error,
          dialogShow: DialogShow.error,
          dialogData: DialogData(
            message: 'Ocurrio un problema',
            title: 'Error',
            textButton: 'Cerrrar',
            onPressed: () {
              onChangeDialog(DialogShow.none);
              Dialogs.close();
            },
            barrierDismissible: false,
          ),
        ));
      }
    }
  }

  bool isFormValid() {
    final isEnableForm = formKey.currentState;
    return isEnableForm != null && formKey.currentState!.validate();
  }

  Future<bool> saveSession(UserEntity userEntity) async {
    final response = await _saveSessionUseCase.call(params: userEntity);
    if (response is DataSuccess) {
      return response.data!;
    } else {
      return false;
    }
  }

  Future<DataState<UserEntity>> submit(String password, String userName) async {
    return await _loginUseCase(params: LoginParams(userName, password));
  }

  String? Function(String?) get validationUserName => (String? value) {
        if (!InputValidators.isRequired(value)) {
          return "No se permite vacios";
        }

        return null;
      };
  String? Function(String?) get validationPassword => (String? value) {
        if (!InputValidators.isRequired(value)) {
          return "No se permite vacios";
        }

        return null;
      };
}
