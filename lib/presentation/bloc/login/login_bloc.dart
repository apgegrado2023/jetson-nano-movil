import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_prgrado/core/resources/data_state.dart';
import 'package:flutter_application_prgrado/domain/entities/user.dart';
import 'package:flutter_application_prgrado/domain/usecases/login.dart';
import 'package:flutter_application_prgrado/domain/usecases/save_session.dart';
import 'package:flutter_application_prgrado/presentation/bloc/login/login_event.dart';
import 'package:flutter_application_prgrado/presentation/bloc/login/login_state.dart';
import 'package:flutter_application_prgrado/presentation/bloc/session/bloc/session_bloc.dart';
import 'package:flutter_application_prgrado/presentation/bloc/session/bloc/session_event.dart';

import '../../../config/routes/routes.dart';
import '../../../config/utils/input_validators.dart';
import '../../../data/models/error_dialog_data.dart';
import '../../widgets/dialogs/dialogs.dart';
import '../../widgets/loading/loading.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SessionBloc sessionBloc;
  final SaveSessionUseCase _saveSessionUseCase;
  final LoginUseCase _loginUseCase;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  LoginBloc(
    this.sessionBloc,
    this._saveSessionUseCase,
    this._loginUseCase,
  ) : super(const LoginState()) {
    on<EmailChangedLoginEvent>((event, emit) => _onEmailChanged(event, emit));
    on<PasswordChangedLoginEvent>(
        (event, emit) => _onPasswordChanged(event, emit));
    on<LoginSubmittedLoginEvent>((event, emit) {
      _onLoginSubmitted(event, emit);
    });
  }

  void _onEmailChanged(
    EmailChangedLoginEvent event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(
      email: event.emailString,
    ));
  }

  void _onPasswordChanged(
    PasswordChangedLoginEvent event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(
      password: event.passwordString,
    ));
  }

  Future<void> _onLoginSubmitted(
    LoginSubmittedLoginEvent event,
    Emitter<LoginState> emit,
  ) async {
    final buildContext = event.context;

    if (!isFormValid()) return;

    Loading.showText(buildContext, "Iniciando Sesión...");

    final email = state.email;
    final password = state.password;

    final response = await submit(password!, email!);

    Loading.close();
    if (response is DataSuccess) {
      saveSession(response.data!);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (Navigator.canPop(buildContext)) {
          Navigator.pushReplacementNamed(buildContext, Routes.home);
        }
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showErrorMessage(buildContext, event, emit);
      });
    }
  }

  Future<void> showErrorMessage(
    BuildContext buildContext,
    LoginSubmittedLoginEvent event,
    Emitter<LoginState> emit,
  ) async {
    Dialogs.showErrorMessage(
      buildContext,
      ErrorDialogData(
        "Ocurrió un problema al iniciar sesión, puede que no tenga una cuenta.",
        "Error",
        "Reintentar",
        () async {
          Dialogs.close();
          await _onLoginSubmitted(event, emit);
        },
        false,
      ),
    );
  }

  bool isFormValid() {
    final isEnableForm = formKey.currentState;
    return isEnableForm != null && formKey.currentState!.validate();
  }

  Future<bool> saveSession(UserEntity userEntity) async {
    sessionBloc.add(SaveSessionEvent(userEntity));
    final response = await _saveSessionUseCase.call(params: userEntity);
    if (response is DataSuccess) {
      return response.data!;
    } else {
      return false;
    }
  }

  Future<DataState<UserEntity>> submit(String password, String userName) async {
    return await _loginUseCase.call(params: LoginParams(userName, password));
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
