import 'package:flutter/material.dart';
import 'package:flutter_application_prgrado/injection_container.dart';
import 'package:flutter_application_prgrado/presentation/bloc/session/bloc/session_bloc.dart';
import 'package:flutter_application_prgrado/presentation/bloc/session/bloc/session_event.dart';
import 'package:flutter_application_prgrado/presentation/pages/login/cubit/login_cubit.dart';
import 'package:flutter_application_prgrado/presentation/widgets/dialogs/dialogs.dart';
import 'package:flutter_application_prgrado/presentation/widgets/loading/loading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/routes/routes.dart';
import '../../widgets/inputs/custom_button.dart';
import '../../widgets/inputs/custom_input_field_state.dart';
import '../../widgets/inputs/custom_textButton.dart';
import '../../widgets/text/custom_title.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LoginCubit>(),
      child: LoginView(),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final sessionBloc = context.read<SessionBloc>();
    return MultiBlocListener(
      listeners: [
        BlocListener<LoginCubit, LoginState>(
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
        BlocListener<LoginCubit, LoginState>(
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
            //context.read<LoginCubit>().onChangeDialog(DialogShow.none);
          },
        ),
        BlocListener<LoginCubit, LoginState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status == LoginStatus.success) {
              sessionBloc.add(SaveSessionEvent(state.userEntity));
              sessionBloc.add(const ConnectedSessionEvent(true));
              Navigator.pushReplacementNamed(context, Routes.home);
            }
          },
        ),
      ],
      child: LoginBody(),
    );
  }
}

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    final Image image = Image.asset(
      'assets/images/logo1.png',
      width: 70,
    );

    final Image imageFont = Image.asset(
      'assets/images/font2.png',
      width: 220,
    );
    final color = Color(0xFF151515);
    final cubit = context.read<LoginCubit>();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              /* image: DecorationImage(
              image: AssetImage('assets/images/back2.jpg'), // Ruta de la imagen
              fit: BoxFit.cover,
            ),*/
              color: color),
          child: Container(
            //color: color.withOpacity(0.6), // Color azul con opacidad
            child: Column(
              children: [
                SizedBox(
                  height: 80,
                ),
                image,
                SizedBox(
                  height: 20,
                ),
                imageFont,
                SizedBox(
                  height: 80,
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ), // Forma del borde (borde redondeado)
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: BlocBuilder<LoginCubit, LoginState>(
                        builder: (contextBloc, state) {
                          return Form(
                            key: cubit.formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /*SizedBox(
                                  width: 100,
                                  child: Image.network(
                                      'https://www.shutterstock.com/image-vector/gratis-speech-bubble-sign-banner-260nw-1475059691.jpg'),
                                ),*/
                                const SizedBox(
                                  height: 30,
                                ),
                                CustomTitle2(
                                  isBoldTitle: true,
                                  colorTitle: color,
                                  fontSize: 25,
                                  title: 'Hola! Bienvenido',
                                  subTitle: 'Inicie sesión en su cuenta',
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Nombre de usuario o número de teléfono",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                CustomInputFieldState(
                                  validator: cubit.validationUserName,
                                  icon:
                                      const Icon(Icons.person_add_alt_1_sharp),
                                  label: "Usuario o telefono",
                                  onChanged: (value) =>
                                      cubit.onEmailChanged(value),
                                ),
                                Text(
                                  "Contraseña",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                CustomInputFieldState(
                                  validator: cubit.validationPassword,
                                  icon: const Icon(Icons.security_outlined),
                                  label: "Contraseña",
                                  onChanged: (value) =>
                                      cubit.onPasswordChanged(value),
                                  isPassword: true,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomButton(
                                    colorButton: color,
                                    height: 49,
                                    colorTextButton: Colors.white,
                                    textButton: 'Iniciar Sesión',
                                    onPressed: () => cubit.onLoginSubmitted()),
                                const SizedBox(height: 50),
                                Center(
                                  child: const Text(
                                    '¿No tengo una cuenta?',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Center(
                                  child: CustomTextButton(
                                    color: color,
                                    text: 'Crear cuenta',
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, Routes.register);
                                    },
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
