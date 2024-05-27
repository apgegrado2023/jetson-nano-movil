import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_prgrado/core/resources/data_state.dart';
import 'package:flutter_application_prgrado/data/data_sources/failures.dart';
import 'package:flutter_application_prgrado/data/models/warning_dialog_data.dart';
import 'package:flutter_application_prgrado/domain/entities/user.dart';
import 'package:flutter_application_prgrado/domain/usecases/save_session.dart';
import 'package:flutter_application_prgrado/domain/usecases/save_user.dart';
import 'package:flutter_application_prgrado/presentation/widgets/dialogs/dialogs.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(
    this._saveUserUseCase,
    this._saveSessionUseCase,
  ) : super(RegisterState());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final SaveUserUseCase _saveUserUseCase;
  final SaveSessionUseCase _saveSessionUseCase;

  void started() {}

  void onChangedName(String name) {
    emit(
      state.copyWith(
        name: name,
      ),
    );
  }

  void onChangedPassword(String password) {
    emit(
      state.copyWith(
        password: password,
      ),
    );
  }

  void onChangedLastName(String lastName) {
    state.copyWith(
      lastName: lastName,
    );
  }

  void onChangedUserName(String userName) {
    emit(
      state.copyWith(
        userName: userName,
      ),
    );
  }

  void onChangedLastNameSecond(String lastNameSecond) {
    emit(state.copyWith(
      lastNameSecond: lastNameSecond,
    ));
  }

  void onChangeDialog(DialogShow dialogShow) {
    emit(state.copyWith(dialogShow: dialogShow));
  }

  Future<void> onRegisterSubmitted() async {
    if (!isFormValid()) return;

    emit(state.copyWith(
      status: RegisterStatus.loading,
      loadingDialog: LoadingDialog.open,
      messageDialogLoading: 'Iniciando sesión...',
    ));
    UserEntity user = createUserFromState(state);
    final response = await _saveUserUseCase.call(params: user);

    if (response is DataSuccess) {
      saveSession(user);
      emit(state.copyWith(
        status: RegisterStatus.success,
        loadingDialog: LoadingDialog.close,
        user: user,
      ));
    } else if (response is DataFailed) {
      if (response.failure is NoInternetFailure) {
        emit(state.copyWith(
          loadingDialog: LoadingDialog.close,
          status: RegisterStatus.error,
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
      } else if (response.failure is ConflictFailure) {
        emit(state.copyWith(
          loadingDialog: LoadingDialog.close,
          status: RegisterStatus.warning,
          dialogShow: DialogShow.warning,
          dialogData: DialogData(
            message: "El usuario o telefono ya se encuentran en uso!",
            title: "Problemas",
            textButton: "Cerrar",
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
          status: RegisterStatus.error,
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

  Future<bool> saveSession(UserEntity userEntity) async {
    final response = await _saveSessionUseCase.call(params: userEntity);
    if (response is DataSuccess) {
      return response.data!;
    } else {
      return false;
    }
  }

  String generarIdUnico() {
    final now = DateTime.now();
    final formattedDate = "${now.year}${now.month}${now.day}";
    final random = Random();
    final letrasAleatorias = String.fromCharCodes(
      List.generate(4, (index) => random.nextInt(26) + 65),
    );

    final idUnico = "$formattedDate$letrasAleatorias";

    return idUnico;
  }

  UserEntity createUserFromState(RegisterState state) {
    final id = generarIdUnico();

    final user = UserEntity(
      id: id,
      name: state.name,
      lastName: state.lastName,
      lastNameSecond: state.lastNameSecond,
      creatorId: '0',
      userName: state.userName,
      password: state.password,
      registrationDate: DateTime.now(),
      updateDate: DateTime.now(),
      status: 1,
      typeUser: 'driver',
    );

    return user;
  }

  bool isFormValid() {
    final isEnableForm = formKey.currentState;
    return isEnableForm != null && formKey.currentState!.validate();
  }
}
