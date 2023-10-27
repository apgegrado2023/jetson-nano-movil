import 'package:flutter/material.dart';
import 'package:flutter_application_prgrado/presentation/bloc/register/register_event.dart';
import 'package:flutter_application_prgrado/presentation/bloc/register/register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../session/bloc/session_bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final SessionBloc sessionBloc;
  //final authenticationRepository = Get.find<AuthenticationRepository>();
  // AuthenticationRepositoryImpl();
  //final userRepository = UserRepositoryImpl();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RegisterBloc(this.sessionBloc) : super(const RegisterState()) {
    on<StartedRegisterEvent>((event, emit) => _started);
    on<NameChangedRegisterEvent>(
      (event, emit) => _onChangedName,
    );
    on<LastNameChangedRegisterEvent>(
      (event, emit) => _onChangedLastName,
    );
    on<LastNameSecondChangedRegisterEvent>(
      (event, emit) => _onChangedLastNameSecond,
    );
    on<PasswordChangedRegisterEvent>(
      (event, emit) => _onChangedPassword,
    );
    on<LoginSubmittedRegisterEvent>(
      (event, emit) => _onLoginSubmitted,
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
        name: event.password,
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

  void _onChangedLastNameSecond(
    LastNameSecondChangedRegisterEvent event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(
      lastNameSecond: event.lastNameSecond,
    ));
  }

  Future<void> _onLoginSubmitted(
    LoginSubmittedRegisterEvent event,
    Emitter<RegisterState> emit,
  ) async {
    /*if (!context.mounted) return;

    if (!isFormValid()) return;
    FocusScope.of(context).unfocus();
    Loading.showText(context, "Registrando");
    final response = await _submit();
    Loading.close();
    if (response) {
      if (!context.mounted) return;

      Dialogs.showGoodMessage(
        context,
        GoodDialogData(
          "El registro de maestro de Escuela sábatica fue exitoso",
          "Registro Exitoso",
          "Cerrar",
          () {
            Dialogs.close();
            _closeForm(context);
          },
          false,
        ),
      );
      return;
    }
*/
    /*if (!context.mounted) return;
    Dialogs.showErrorMessage(
      context,
      ErrorDialogData(
        "No se registro un maestro de Escuela sábatica",
        "Registro Fallido",
        "Reintentar",
        () => {Dialogs.close(), _onLoginSubmitted(emit, context)},
        false,
      ),
    );
  }

  _closeForm(BuildContext context) {
    Navigator.pop(context);*/
  }

  /*Future<bool> _submit() async {
    /*final password =
        Functions.generarContrasena2(state.name!, DateTime.now().toString());
    final user = await authenticationRepository.createUserWithEmailAndPassword(
        state.email!, password);
    if (user == null) return false;

    Member teacher = Member.createStaffMember(
      uid: user.uid,
      name: state.name!,
      nameSecond: state.nameSecond!,
      lastName: state.lastName!,
      lastNameSecond: state.lastNameSecond!,
      gender: state.gender!,
      phone: state.phone!,
      bautizated: state.bautizated!,
      birthDate: state.birthDate!,
      typeUser: UserTypes.TEACHER,
      creatorId: sessionBloc.state.member!.id,
      email: state.email!,
      password: password,
    );

    final response = await userRepository.insertBool(teacher);
    if (response) {
      final email = EmailService(teacher.email, "Contraseña cuenta System EESS",
          "Contraseña: ${teacher.password}");
      final r = await email.sendEmail();
      print(r);
    }
    return response;
  }

  bool isFormValid() {
    final isEnableForm = formKey.currentState;
    return isEnableForm != null && formKey.currentState!.validate();
  }*/
}*/
}
