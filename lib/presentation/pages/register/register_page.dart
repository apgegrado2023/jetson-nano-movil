import 'package:flutter/material.dart';
import 'package:flutter_application_prgrado/config/routes/routes.dart';
import 'package:flutter_application_prgrado/presentation/session/bloc/session_bloc.dart';
import 'package:flutter_application_prgrado/presentation/session/bloc/session_event.dart';
import 'package:flutter_application_prgrado/presentation/pages/register/cubit/register_cubit.dart';
import 'package:flutter_application_prgrado/presentation/widgets/appBar/appBar_custom.dart';
import 'package:flutter_application_prgrado/presentation/widgets/dialogs/dialogs.dart';
import 'package:flutter_application_prgrado/presentation/widgets/inputs/custom_input_field_state.dart';
import 'package:flutter_application_prgrado/presentation/widgets/loading/loading.dart';
import 'package:flutter_application_prgrado/presentation/widgets/text/custom_title.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/utils/validators.dart';
import '../../../injection_container.dart';
import '../../widgets/inputs/custom_button.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<RegisterCubit>(),
      child: RegisterView(),
    );
  }
}

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final sessionBloc = context.read<SessionBloc>();
    return MultiBlocListener(
      listeners: [
        BlocListener<RegisterCubit, RegisterState>(
          listenWhen: (previous, current) =>
              previous.loadingDialog != current.loadingDialog,
          listener: (context, state) {
            if (state.loadingDialog == LoadingDialog.open) {
              Loading.showText(context, state.messageDialogLoading);
            } else if (state.loadingDialog == LoadingDialog.close) {
              Loading.close();
            }
          },
        ),
        BlocListener<RegisterCubit, RegisterState>(
          listenWhen: (previous, current) =>
              previous.dialogShow != current.dialogShow,
          listener: (context, state) {
            final dialogData = state.dialogData;
            if (state.dialogShow == DialogShow.warning) {
              Dialogs.showWarningMessage(context, dialogData);
            } else if (state.dialogShow == DialogShow.error) {
              Dialogs.showErrorMessage(context, dialogData);
            } else if (state.dialogShow == DialogShow.success) {
              Dialogs.showGoodMessage(context, dialogData);
            }
            //context.read<RegisterCubit>().onChangeDialog(DialogShow.none);
          },
        ),
        BlocListener<RegisterCubit, RegisterState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status == RegisterStatus.success) {
              sessionBloc.add(SaveSessionEvent(state.user));
              sessionBloc.add(const ConnectedSessionEvent(true));
              Navigator.pushReplacementNamed(context, Routes.home);
            }
          },
        ),
      ],
      child: const RegisterBody(),
    );
  }
}

class RegisterBody extends StatelessWidget {
  const RegisterBody({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Color(0xFF151515);
    final bloc = context.read<RegisterCubit>();
    final Image image = Image.asset(
      'assets/images/logo1.png',
      width: 70,
    );
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBarCustom(
        background: color,
        title: '',
        colorIcon: Colors.white,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: BlocBuilder<RegisterCubit, RegisterState>(
            bloc: bloc,
            builder: (contextBloc, state) {
              return Form(
                key: bloc.formKey,
                child: Container(
                  color: color,
                  child: Column(
                    children: [
                      image,
                      SizedBox(
                        height: 20,
                      ),
                      const CustomTitle2(
                        isBoldTitle: true,
                        fontSize: 25,
                        textAlignTitle: TextAlign.center,
                        textAlignSubTitle: TextAlign.center,
                        title: "Crear una cuenta",
                        subTitle: "Registro de usuario",
                        colorSubTitle: Colors.white,
                        colorTitle: Colors.white,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ), // Forma del borde (borde redondeado)
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nombres',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            CustomInputFieldState(
                              onChanged: (value) => bloc.onChangedName(value),
                              icon: const Icon(Icons.person_2),
                              isCapitalize: true,
                              //icon: const Icon(Icons.person),
                              label: "Nombres",
                              isNoSpace: false,
                              validator: Validators.validationText,
                            ),
                            Text(
                              'Apellidos',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            CustomInputFieldState(
                              onChanged: (value) =>
                                  bloc.onChangedLastName(value),
                              icon: const Icon(Icons.person_2_outlined),
                              isCapitalize: true,
                              isNoSpace: false,
                              //icon: const Icon(Icons.abc),
                              label: "Apellidos",
                              validator: Validators.validationText,
                            ),
                            Text(
                              "Nombre de usuario o número de teléfono",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            CustomInputFieldState(
                              onChanged: (value) =>
                                  bloc.onChangedUserName(value),
                              icon: const Icon(Icons.person_add_alt_1_sharp),
                              label: "Usuario o telefono",
                              validator: Validators.validationText,
                            ),
                            Text(
                              "Contraseña",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            CustomInputFieldState(
                              onChanged: (value) =>
                                  bloc.onChangedPassword(value),
                              icon: const Icon(Icons.security),
                              label: "Contraseña",
                              isPassword: true,
                              validator: (v) =>
                                  Validators.validationPassword(v),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomButton(
                              height: 48,
                              colorButton: color,
                              colorTextButton: Colors.white,
                              textButton: 'Registrar',
                              onPressed: () => bloc.onRegisterSubmitted(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

bool isValidEmail(String text) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(text);
}
