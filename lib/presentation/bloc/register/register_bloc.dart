import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_prgrado/domain/repository/user_repository.dart';
import 'package:flutter_application_prgrado/presentation/bloc/register/register_event.dart';
import 'package:flutter_application_prgrado/presentation/bloc/register/register_state.dart';
import 'package:flutter_application_prgrado/presentation/widgets/dialogs/dialogs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/routes/routes.dart';
import '../../../data/models/error_dialog_data.dart';
import '../../../data/models/good_dialog_data.dart';
import '../../../data/models/user.dart';
import '../../../domain/repository/session_repository.dart';
import '../../widgets/loading/loading.dart';
import '../session/bloc/session_bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final SessionBloc sessionBloc;
  final UserRepository userRepository;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final SessionRepository session;

  RegisterBloc(
    this.sessionBloc,
    this.userRepository,
    this.session,
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
    // if (!event. context.) return;
    final BuildContext buildContext = event.context;
    if (!isFormValid()) return;
    //FocusScope.of(buildContext).unfocus();
    Loading.showText(buildContext, "Registrando");
    final response = await _submit();
    Loading.close();
    if (response != null) {
      setUserInSession(response);
      await session.saveToSession(response);
      // Navega a la ruta después de asegurarte de que el contexto esté montado
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

  void setUserInSession(User response) {
    sessionBloc.setUser(response);
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

  _closeForm(BuildContext context) {
    Navigator.pop(context);
  }

  String generarIdUnico() {
    final now = DateTime.now();
    final formattedDate = "${now.year}${now.month}${now.day}";
    final random = Random();
    final letrasAleatorias = String.fromCharCodes(List.generate(4,
        (index) => random.nextInt(26) + 65)); // Genera letras aleatorias (A-Z).

    final idUnico = "$formattedDate$letrasAleatorias";

    return idUnico;
  }

  Future<User?> _submit() async {
    User teacher = User.create(
      id: generarIdUnico(),
      name: state.name!,
      lastName: state.lastName!,
      lastNameSecond: state.lastNameSecond!,
      creatorId: '0',
      userName: state.userName!,
      password: state.password!,
    );

    final response = await userRepository.insert(teacher);
    if (response) return teacher;
    return null;
  }

  bool isFormValid() {
    final isEnableForm = formKey.currentState;
    return isEnableForm != null && formKey.currentState!.validate();
  }
}
