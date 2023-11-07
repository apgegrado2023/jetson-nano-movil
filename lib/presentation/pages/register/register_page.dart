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
    final color = CustomColorPrimary().c;
    final bloc = sl<RegisterBloc>();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBarCustom(
        background: color,
        title: '',
        colorIcon: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<RegisterBloc, RegisterState>(
          bloc: bloc,
          builder: (contextBloc, state) {
            return Form(
              key: bloc.formKey,
              child: Container(
                color: color,
                child: Column(
                  children: [
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
                            icon: const Icon(Icons.abc),
                            label: "Nombre",
                            validator: Validators.validationText,
                          ),
                          CustomInputField(
                            onChanged: (value) => bloc.add(
                              LastNameChangedRegisterEvent(value),
                            ),
                            isCapitalize: true,
                            icon: const Icon(Icons.abc),
                            label: "Primer Apellido",
                            validator: Validators.validationText,
                          ),
                          CustomInputField(
                            onChanged: (value) => bloc.add(
                              LastNameSecondChangedRegisterEvent(value),
                            ),
                            icon: const Icon(Icons.abc),
                            label: "Segundo Apellido",
                            isCapitalize: true,
                            validator: Validators.validationText,
                          ),
                          Text("Datos para inicio de Sesión"),
                          CustomInputField(
                            onChanged: (value) => bloc.add(
                              UserNameChangedRegisterEvent(value),
                            ),
                            icon: const Icon(Icons.abc),
                            label: "Usuario",
                            validator: Validators.validationText,
                          ),
                          CustomInputField(
                            onChanged: (value) => bloc.add(
                              PasswordChangedRegisterEvent(value),
                            ),
                            icon: const Icon(Icons.password),
                            label: "Contraseña",
                            validator: Validators.validationPassword,
                          ),
                          CustomButton(
                            height: 48,
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
    );
  }
}

bool isValidEmail(String text) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(text);
}
