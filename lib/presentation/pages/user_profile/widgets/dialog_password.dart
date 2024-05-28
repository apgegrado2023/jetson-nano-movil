import 'package:flutter/material.dart';
import 'package:flutter_application_prgrado/presentation/bloc/profile/profile_bloc.dart';
import 'package:flutter_application_prgrado/presentation/widgets/inputs/custom_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DialogPassword extends StatelessWidget {
  DialogPassword({super.key});
  final _miControllerPass = TextEditingController();
  final _miControllerPassNew = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfileBloc>();
    return AlertDialog(
      icon: Icon(Icons.password),
      title: Text(
        'Cambiar Contraseña',
      ),
      content: SingleChildScrollView(
        child: Form(
          key: bloc.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Contraseña Actual'),
                //obscureText: true,
                controller: _miControllerPass,
                validator: _validateInput,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Nueva Contraseña'),
                //obscureText: true,
                controller: _miControllerPassNew,
                validator: _validateInput,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      textButton: 'Cancelar',
                      width: 100,
                      colorBorderButton: Color.fromARGB(255, 83, 83, 83),
                      colorButton: Colors.white,
                      colorTextButton: Color.fromARGB(255, 83, 83, 83),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: CustomButton(
                      textButton: 'Cambiar',
                      colorTextButton: Colors.white,
                      width: 100,
                      colorButton: Color.fromARGB(255, 83, 83, 83),
                      onPressed: () {
                        bloc.add(
                          PasswordChangedProfileEvent(
                            _miControllerPass.text,
                            _miControllerPassNew.text,
                            context,
                          ),
                        );
                      },
                      //child: Text('Cambiar'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  String? _validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo no puede estar vacío';
    }

    return null;
  }
}
