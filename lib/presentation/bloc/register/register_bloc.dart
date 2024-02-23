import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_prgrado/core/resources/data_state.dart';
import 'package:flutter_application_prgrado/data/models/warning_dialog_data.dart';
import 'package:flutter_application_prgrado/domain/entities/user.dart';
import 'package:flutter_application_prgrado/domain/repository/user_repository.dart';
import 'package:flutter_application_prgrado/domain/usecases/save_session.dart';
import 'package:flutter_application_prgrado/domain/usecases/save_user.dart';
import 'package:flutter_application_prgrado/presentation/bloc/register/register_event.dart';
import 'package:flutter_application_prgrado/presentation/bloc/register/register_state.dart';
import 'package:flutter_application_prgrado/presentation/bloc/session/bloc/session_event.dart';
import 'package:flutter_application_prgrado/presentation/widgets/dialogs/dialogs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/routes/routes.dart';
import '../../../data/models/error_dialog_data.dart';
import '../../../data/models/user.dart';
import '../../widgets/loading/loading.dart';
import '../session/bloc/session_bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final SessionBloc sessionBloc;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final SaveUserUseCase _saveUserUseCase;
  final SaveSessionUseCase _saveSessionUseCase;

  RegisterBloc(
    this.sessionBloc,
    this._saveUserUseCase,
    this._saveSessionUseCase,
  ) : super(const RegisterState()) {
    on<StartedRegisterEvent>((event, emit) => _started());
    on<NameChangedRegisterEvent>(
      (event, emit) => _onChangedName(event, emit),
    );
    on<LastNameChangedRegisterEvent>(
      (event, emit) => _onChangedLastName(event, emit),
    );
    on<LastNameSecondChangedRegisterEvent>(
      (event, emit) => _onChangedLastNameSecond(event, emit),
    );
    on<PasswordChangedRegisterEvent>(
      (event, emit) => _onChangedPassword(event, emit),
    );
    on<RegisterSubmittedRegisterEvent>((event, emit) {
      _onRegisterSubmitted(event, emit);
    });
    on<UserNameChangedRegisterEvent>(
      (event, emit) => _onChangedUserName(event, emit),
    );
  }

  void _started() {}

  void _onChangedName(
    NameChangedRegisterEvent event,
    Emitter<RegisterState> emit,
  ) {
    emit(
      state.copyWith(
        name: event.name,
      ),
    );
  }

  void _onChangedPassword(
    PasswordChangedRegisterEvent event,
    Emitter<RegisterState> emit,
  ) {
    emit(
      state.copyWith(
        password: event.password,
      ),
    );
  }

  void _onChangedLastName(
    LastNameChangedRegisterEvent event,
    Emitter<RegisterState> emit,
  ) {
    emit(
      state.copyWith(
        lastName: event.lastName,
      ),
    );
  }

  void _onChangedUserName(
    UserNameChangedRegisterEvent event,
    Emitter<RegisterState> emit,
  ) {
    emit(
      state.copyWith(
        userName: event.userName,
      ),
    );
  }

  void _onChangedLastNameSecond(
    LastNameSecondChangedRegisterEvent event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(
      lastNameSecond: event.lastNameSecond,
    ));
  }

  Future<void> _onRegisterSubmitted(
    RegisterSubmittedRegisterEvent event,
    Emitter<RegisterState> emit,
  ) async {
    final buildContext = event.context;
    if (!isFormValid()) return;

    Loading.showText(buildContext, "Registrando...");
    UserEntity user = createUserFromState(state);
    final response = await _saveUserUseCase.call(params: user);
    Loading.close();

    if (response is DataSuccess) {
      if (response.data!) {
        await saveSession(user);

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

    if (response is DataFailed2) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showWarningMessage(buildContext);
      });
    }
  }

  Future<bool> saveSession(UserEntity userEntity) async {
    sessionBloc.add(SaveSessionEvent(userEntity));
    sessionBloc.add(const ConnectedSessionEvent(true));
    final response = await _saveSessionUseCase.call(params: userEntity);
    if (response is DataSuccess) {
      return response.data!;
    } else {
      return false;
    }
  }

  void navigateToHome(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Navigator.canPop(context)) {
        Future.microtask(() {
          Navigator.pushReplacementNamed(context, Routes.home);
        });
      }
    });
  }

  Future<void> showErrorMessage(
    BuildContext buildContext,
    RegisterSubmittedRegisterEvent event,
    Emitter<RegisterState> emit,
  ) async {
    Dialogs.showErrorMessage(
      buildContext,
      ErrorDialogData(
        "No se registro un nuevo usuario",
        "Registro Fallido",
        "Reintentar",
        () async {
          Dialogs.close();
          await _onRegisterSubmitted(event, emit); // Llamada al mismo método
        },
        false,
      ),
    );
  }

  Future<void> showWarningMessage(
    BuildContext buildContext,
  ) async {
    Dialogs.showWarningMessage(
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
    );
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
    print(id);
    final user = UserEntity(
      id: id,
      name: state.name ?? '',
      lastName: state.lastName ?? '',
      lastNameSecond: state.lastNameSecond ?? '',
      creatorId: '0',
      userName: state.userName ?? '',
      password: state.password ?? '',
      registrationDate: DateTime.now(),
      updateDate: DateTime.now(),
      status: 1,
      typeUser: 'driver',
    );

    return user;
  }

  Future<DataState<bool>> _submit() async {
    UserEntity user = createUserFromState(state);
    final response = await _saveUserUseCase.call(params: user);
    return response;
  }

  bool isFormValid() {
    final isEnableForm = formKey.currentState;
    return isEnableForm != null && formKey.currentState!.validate();
  }
}
