import 'package:flutter/material.dart';
import 'package:flutter_application_prgrado/config/utils/my_colors.dart';
import 'package:flutter_application_prgrado/presentation/widgets/appBar/appBar_custom.dart';
import 'package:flutter_application_prgrado/presentation/widgets/text/custom_title.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/utils/validators.dart';
import '../../../injection_container.dart';
import '../../bloc/register/register_bloc.dart';
import '../../bloc/register/register_event.dart';
import '../../bloc/register/register_state.dart';
import '../../widgets/inputs/custom_button.dart';
import '../../widgets/inputs/custom_input_field.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Color(0xFF151515);
    final bloc = sl<RegisterBloc>();
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
          child: BlocBuilder<RegisterBloc, RegisterState>(
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
                          children: [
                            CustomInputField(
                              onChanged: (value) => bloc.add(
                                NameChangedRegisterEvent(value),
                              ),
                              isCapitalize: true,
                              //icon: const Icon(Icons.person),
                              label: "Nombre",
                              validator: Validators.validationText,
                            ),
                            CustomInputField(
                              onChanged: (value) => bloc.add(
                                LastNameChangedRegisterEvent(value),
                              ),
                              isCapitalize: true,
                              isNoSpace: false,
                              //icon: const Icon(Icons.abc),
                              label: "Apellidos",
                              validator: Validators.validationText,
                            ),
                            Text("Datos para inicio de Sesión"),
                            CustomInputField(
                              onChanged: (value) => bloc.add(
                                UserNameChangedRegisterEvent(value),
                              ),
                              icon: const Icon(Icons.person),
                              label: "Usuario",
                              validator: Validators.validationText,
                            ),
                            CustomInputField(
                              onChanged: (value) => bloc.add(
                                PasswordChangedRegisterEvent(value),
                              ),
                              icon: const Icon(Icons.password),
                              label: "Contraseña",
                              isPassword: true,
                              validator: Validators.validationPassword,
                            ),
                            CustomButton(
                              colorButton: color,
                              textButton: 'Registrar',
                              onPressed: () => bloc.add(
                                RegisterSubmittedRegisterEvent(context),
                              ),
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
