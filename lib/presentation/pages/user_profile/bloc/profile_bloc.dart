import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_prgrado/config/routes/routes.dart';
import 'package:flutter_application_prgrado/core/resources/data_state.dart';
import 'package:flutter_application_prgrado/data/models/error_dialog_data.dart';
import 'package:flutter_application_prgrado/data/models/good_dialog_data.dart';
import 'package:flutter_application_prgrado/data/models/warning_dialog_data.dart';
import 'package:flutter_application_prgrado/domain/entities/user.dart';
import 'package:flutter_application_prgrado/domain/usecases/change_password.dart';
import 'package:flutter_application_prgrado/domain/usecases/save_session.dart';
import 'package:flutter_application_prgrado/domain/usecases/update_filed_user.dart';
import 'package:flutter_application_prgrado/presentation/session/bloc/session_bloc.dart';
import 'package:flutter_application_prgrado/presentation/session/bloc/session_event.dart';
import 'package:flutter_application_prgrado/presentation/widgets/dialogs/dialogs.dart';
import 'package:flutter_application_prgrado/presentation/widgets/loading/loading.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final SessionBloc sessionBloc;
  final UpdateFileUserUseCase _updateFileUserUseCase;

  final SaveSessionUseCase _saveSessionUseCase;
  final ChangePasswordUseCase _changePasswordUseCase;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ProfileBloc(
    this.sessionBloc,
    this._updateFileUserUseCase,
    this._saveSessionUseCase,
    this._changePasswordUseCase,
  ) : super(ProfileState()) {
    on<StartedEvent>((event, emit) => _started(event, emit));
    on<NameChangedProfileEvent>(_onChangedName);

    on<LastNameChangedProfileEvent>(_onChangedLastName);
    on<PasswordChangedProfileEvent>(_onChangedPassword);

    on<UserNameChangedProfileEvent>(_onChangedUserName);
  }
  void _started(
    StartedEvent event,
    Emitter<ProfileState> emit,
  ) {
    final user = sessionBloc.state.user;
    emit(state.copyWith(userEntity: user));
  }

  Future<void> _onChangedName(
    NameChangedProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    final buildContext = event.context;
    await onChangeCustomer(emit, 'name', event.name, buildContext);
    /*if (!isFormValid()) return;

    Loading.showText(buildContext, "Cambiando...");
    final response = await _updateFileUserUseCase.call(
        params: UpdateFileUserParams(
            sessionBloc.state.user!.id!, 'name', event.name));
    Loading.close();

    await Future.delayed(Duration(microseconds: 500));

    if (response is DataSuccess) {
      final res = await saveSession(response.data!);
      if (res) {
        final user = sessionBloc.state.user;
        emit(state.copyWith(userEntity: user));
        Navigator.pop(buildContext);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showGoodMessage(buildContext);
          });
        });
      }
      return;
    }

    if (response is DataFailed2) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showWarningMessage(buildContext);
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showErrorMessage(
          buildContext,
        );
      });
    }*/
  }

  Future<void> onChangeCustomer(Emitter<ProfileState> emit, title, value,
      BuildContext buildContext) async {
    if (!isFormValid()) return;

    Loading.showText(buildContext, "Cambiando...");
    final response = await _updateFileUserUseCase.call(
        params:
            UpdateFileUserParams(sessionBloc.state.user!.id!, title, value));
    Loading.close();

    await Future.delayed(Duration(microseconds: 500));

    if (response is DataSuccess) {
      final res = await saveSession(response.data!);
      if (res) {
        final user = sessionBloc.state.user;
        emit(state.copyWith(userEntity: user));
        Navigator.pop(buildContext);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showGoodMessage(buildContext);
          });
        });
      }
      return;
    }

    if (response is DataFailed) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showWarningMessage(buildContext);
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showErrorMessage(
          buildContext,
        );
      });
    }
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

  Future<void> _onChangedPassword(
    PasswordChangedProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    /*emit(
      state.copyWith(
        password: event.password,
      ),
    );*/
    final buildContext = event.context;
    if (!isFormValid()) return;

    Loading.showText(buildContext, "Cambiando...");
    final response = await _changePasswordUseCase.call(
        params: ChangePasswordParams(
      sessionBloc.state.user!.id!,
      event.passwordNow,
      event.passwordLast,
    ));
    Loading.close();

    await Future.delayed(Duration(microseconds: 500));

    if (response is DataSuccess) {
      final user = sessionBloc.state.user;
      emit(state.copyWith(userEntity: user));
      Navigator.pop(buildContext);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showGoodMessage(buildContext);
        });
      });

      return;
    }

    /*if (response is DataFailed) {
      if (response.dioException!.response!.statusCode ==
          HttpStatus.unauthorized)
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showPasswordFailedMessage(buildContext);
        });
      else
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showWarningMessage(buildContext);
        });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showErrorMessage(
          buildContext,
        );
      });
    }*/
  }

  Future<void> _onChangedLastName(
    LastNameChangedProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    final buildContext = event.context;
    await onChangeCustomer(emit, 'last_name', event.lastName, buildContext);
  }

  Future<void> _onChangedUserName(
    UserNameChangedProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    final buildContext = event.context;
    await onChangeCustomer(emit, 'user_name', event.userName, buildContext);
  }

  bool isFormValid() {
    final isEnableForm = formKey.currentState;
    return isEnableForm != null && formKey.currentState!.validate();
  }

  Future<void> showErrorMessage(
    BuildContext buildContext,
  ) async {
    /*Dialogs.showErrorMessage(
      buildContext,
      ErrorDialogData(
        "Ocurrio un problema en el cambio de contraseña",
        "Cambio Fallido",
        "Cerrar",
        () async {
          Dialogs.close();
        },
        false,
      ),
    );*/
  }

  Future<void> showWarningMessage(
    BuildContext buildContext,
  ) async {
    /*Dialogs.showWarningMessage(
      buildContext,
      WarningDialogData(
        "No estas conectado y/o el servidor esta apagado",
        "No hay conexión",
        "Cerrar",
        () async {
          Dialogs.close();
        },
        false,
      ),
    );*/
  }

  Future<void> showPasswordFailedMessage(
    BuildContext buildContext,
  ) async {
    /*Dialogs.showWarningMessage(
      buildContext,
      WarningDialogData(
        "La contraseña actual es incorrecta",
        "Contraseña actual invalida",
        "Cerrar",
        () async {
          Dialogs.close();
        },
        false,
      ),
    );*/
  }

  Future<void> showGoodMessage(
    BuildContext buildContext,
  ) async {
    /*Dialogs.showGoodMessage(
      buildContext,
      GoodDialogData(
        "Se cambio el dato",
        "Cambio Exitoso",
        "Cerrar",
        () async {
          Dialogs.close();
          Future.microtask(() {
            Navigator.pushNamedAndRemoveUntil(
                buildContext, Routes.login, (route) => false);
          });
        },
        false,
      ),
    );*/
  }
}
