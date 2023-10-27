import 'package:flutter/material.dart';
import 'package:flutter_application_prgrado/config/utils/my_colors.dart';
import 'package:flutter_application_prgrado/injection_container.dart';
import 'package:flutter_application_prgrado/presentation/bloc/login/login_bloc.dart';
import 'package:flutter_application_prgrado/presentation/bloc/login/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/routes/routes.dart';
import '../../bloc/login/login_event.dart';
import '../../widgets/inputs/custom_button.dart';
import '../../widgets/inputs/custom_input_field_state.dart';
import '../../widgets/inputs/custom_textButton.dart';
import '../../widgets/text/custom_title.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Image image = Image.asset('images/logo.webp');
    final color = CustomColorPrimary().c;
    final bloc = sl<LoginBloc>();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/back2.jpg'), // Ruta de la imagen
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            color: color.withOpacity(0.6), // Color azul con opacidad
            child: Column(
              children: [
                SizedBox(
                  height: 80,
                ),
                Icon(
                  Icons.abc,
                  color: Colors.white,
                  size: 120,
                ),
                Text(
                  "Vision driver",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
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
                      child: BlocBuilder<LoginBloc, LoginState>(
                        bloc: bloc,
                        builder: (contextBloc, state) {
                          return Form(
                            key: bloc.formKey,
                            child: Column(
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
                                CustomInputFieldState(
                                  validator: bloc.validationUserName,
                                  icon: const Icon(Icons.email),
                                  label: "Usuario",
                                  onChanged: (value) => bloc.add(
                                    EmailChangedLoginEvent(value),
                                  ),
                                ),
                                CustomInputFieldState(
                                  validator: bloc.validationPassword,
                                  icon: const Icon(Icons.security_outlined),
                                  label: "Contraseña",
                                  onChanged: (value) => bloc.add(
                                    PasswordChangedLoginEvent(value),
                                  ),
                                  isPassword: true,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                CustomButton(
                                  textButton: 'Iniciar Sesión',
                                  onPressed: () => bloc.add(
                                    LoginSubmittedLoginEvent(context),
                                  ),
                                ),
                                const SizedBox(height: 50),
                                const Text(
                                  '¿No tengo una cuenta?',
                                  textAlign: TextAlign.center,
                                ),
                                CustomTextButton(
                                  text: 'Crear cuenta',
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, Routes.register);
                                  },
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
