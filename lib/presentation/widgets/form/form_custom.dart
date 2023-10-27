import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../text/custom_title.dart';

class FormCustom<B extends Bloc<E, S>, E, S> extends StatelessWidget {
  final GlobalKey formKey;
  const FormCustom({super.key, required this.formKey});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<B, S>(
        builder: (contextBloc, state) {
          final bloc = contextBloc.read<B>();
          return Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomTitle(
                  title: "Registro",
                  subTitle: "Registro de un nuevo maestro de Escuela sabatica",
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color.fromARGB(255, 240, 240, 240)),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Formulario de Registro"),
                      ]),
                ),
                /*Row(
                  children: [
                    Expanded(
                      child: CustomInputField(
                        onChanged: (value) => bloc.add(
                          FormCreateTeacherEvent.nameChanged(value),
                        ),
                        isCapitalize: true,
                        icon: const Icon(Icons.person_2_outlined),
                        label: "Nombre",
                        validator: Validators.validationText,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: CustomInputField(
                        onChanged: (value) => bloc.add(
                          FormCreateTeacherEvent.nameSecondChanged(value),
                        ),
                        isCapitalize: true,
                        icon: const Icon(Icons.person_2_outlined),
                        label: "Segundo Nombre",
                        validator: Validators.validationText,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomInputField(
                        onChanged: (value) => bloc.add(
                          FormCreateTeacherEvent.lastNameChanged(value),
                        ),
                        isCapitalize: true,
                        icon: const Icon(Icons.person_2_outlined),
                        label: "Primer Apellido",
                        validator: Validators.validationText,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: CustomInputField(
                        onChanged: (value) => bloc.add(
                          FormCreateTeacherEvent.lastNameSecondChanged(value),
                        ),
                        icon: const Icon(Icons.person_2_outlined),
                        label: "Segundo Apellido",
                        isCapitalize: true,
                        validator: Validators.validationText,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: SettingsWidget<Bautizated>(
                        onChanged: (value) => bloc.add(
                          FormCreateTeacherEvent.bautizatedChanged(value),
                        ),
                        hint: 'Bautizo',
                        items: [
                          Bautizated("Si Bautizado", true),
                          Bautizated("No Bautizado", false),
                        ],
                        validator: Validators.validationNull,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: SettingsWidget<Gender>(
                        onChanged: (value) => bloc.add(
                          FormCreateTeacherEvent.genderChanged(value),
                        ),
                        hint: 'Genero',
                        items: [
                          Gender("Masculino", "M"),
                          Gender("Femenino", "F"),
                        ],
                        validator: Validators.validationNull,
                      ),
                    )
                  ],
                ),
                CustomInputField(
                  onChanged: (value) => bloc.add(
                    FormCreateTeacherEvent.phoneChanged(value),
                  ),
                  inputType: TextInputType.phone,
                  icon: const Icon(Icons.phone),
                  label: "Numero de Celular",
                  validator: Validators.validationPhone,
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Fecha de Nacimiento"),
                DateOfBirthComboBox(
                  onChanged: (DateTime date) =>
                      bloc.add(FormCreateTeacherEvent.birthDateChanged(date)),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Datos para inicio de Sesión"),
                CustomInputField(
                  inputType: TextInputType.emailAddress,
                  onChanged: (value) => bloc.add(
                    FormCreateTeacherEvent.emailChanged(value),
                  ),
                  icon: const Icon(Icons.email),
                  label: "Correo Electronico",
                  validator: Validators.validationEmail,
                ),
                CustomButton(
                  height: 48,
                  textButton: 'Registrar',
                  onPressed: () => bloc.add(
                    FormCreateTeacherEvent.loginSubmitted(context),
                  ),
                ),*/
              ],
            ),
          );
        },
      ),
    );
  }
}
