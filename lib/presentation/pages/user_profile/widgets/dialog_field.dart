import 'package:flutter/material.dart';
import 'package:flutter_application_prgrado/presentation/bloc/profile/profile_bloc.dart';
import 'package:flutter_application_prgrado/presentation/widgets/inputs/custom_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DialogField extends StatelessWidget {
  DialogField({
    required this.title,
    required this.value,
    required this.label,
    this.isValidatioNum = false,
    required this.onPressed,
  });
  final String value;
  final String title;
  final String label;

  final void Function(String) onPressed;
  final bool isValidatioNum;
  @override
  Widget build(BuildContext context) {
    final _miController = TextEditingController(text: value);
    return AlertDialog(
      icon: Icon(Icons.person),
      title: Text(title),
      content: SingleChildScrollView(
        child: Form(
          key: context.read<ProfileBloc>().formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _miController,
                decoration: InputDecoration(labelText: label),
                validator: isValidatioNum ? _validateInput2 : _validateInput,
              ),
            ],
          ),
        ),
      ),
      actions: [
        CustomButton(
          textButton: 'Cancelar',
          width: 100,
          colorBorderButton: Color.fromARGB(255, 83, 83, 83),
          colorButton: Colors.white,
          colorTextButton: Color.fromARGB(255, 83, 83, 83),
          onPressed: () {
            Navigator.pop(context); // Cerrar el diálogo sin hacer nada
          },
        ),
        CustomButton(
          textButton: 'Cambiar',
          width: 100,
          colorButton: Color.fromARGB(255, 83, 83, 83),
          onPressed: () => onPressed(_miController.text),
        ),
      ],
    );
  }

  String? _validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo no puede estar vacío';
    }
    // Puedes agregar más lógica de validación según tus necesidades

    return null; // Retornar null indica que la validación pasó con éxito
  }

  String? _validateInput2(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo no puede estar vacío';
    }

    // Verificar si hay números en el nombre
    if (RegExp(r'\d').hasMatch(value)) {
      return 'El texto no puede contener números';
    }

    return null; // Retornar null indica que la validación pasó con éxito
  }
}
