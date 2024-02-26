import 'package:flutter/material.dart';
import 'package:flutter_application_prgrado/domain/entities/user.dart';
import 'package:flutter_application_prgrado/presentation/bloc/profile/profile_bloc.dart';
import 'package:flutter_application_prgrado/presentation/widgets/inputs/custom_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../injection_container.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProfileBloc>()..add(const StartedEvent()),
      child: UserProfile(),
    );
  }
}

class UserProfile extends StatelessWidget {
  UserProfile({
    super.key,
  });
  late TextEditingController _miController;
  _widget(
      String title, String child, IconData icon, void Function()? onPressed) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
            10), // Ajusta este valor para cambiar el radio de los bordes
        color: Color.fromARGB(255, 51, 51,
            51), // Cambia el color del contenedor según lo necesites
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  child,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          ),
          IconButton(
              color: Colors.white,
              icon: Icon(Icons.edit),
              onPressed: onPressed),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 24, 24, 24),
      appBar: AppBar(
        title: Text('Perfil de Usuario'),
        backgroundColor: Color.fromARGB(255, 24, 24, 24),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: BlocSelector<ProfileBloc, ProfileState, UserEntity?>(
              //bloc: session,
              selector: (state) => state.userEntity,
              builder: ((context, userEntity) {
                if (userEntity == null) return SizedBox();
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 39, 39, 39),
                        ),
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                      SizedBox(height: 16),
                      _widget(
                          "Nombre:", userEntity.name!, Icon(Icons.person).icon!,
                          () {
                        _showChangeFileDialog(context, 'Cambiar Nombre',
                            userEntity.name!, 'Nombre', () {
                          print('ses1');
                          context.read<ProfileBloc>().add(
                              NameChangedProfileEvent(
                                  _miController.text, context));
                        }, true);
                      }),
                      SizedBox(height: 16),
                      _widget("Apellidos:", userEntity.lastName!,
                          Icon(Icons.person).icon!, () {
                        _showChangeFileDialog(context, 'Cambiar Apellidos',
                            userEntity.lastName!, 'Apellidos', () {
                          print('ses');
                          context.read<ProfileBloc>().add(
                              LastNameChangedProfileEvent(
                                  _miController.text, context));
                        }, true);
                      }),
                      SizedBox(height: 16),
                      _widget("Usuario:", userEntity.userName!,
                          Icon(Icons.person).icon!, () {
                        _showChangeFileDialog(context, 'Cambiar Usuario',
                            userEntity.userName!, 'Usuario', () {
                          print('ses');
                          context.read<ProfileBloc>().add(
                              UserNameChangedProfileEvent(
                                  _miController.text, context));
                        }, false);
                      }),
                      SizedBox(height: 16),
                      Divider(
                        color: Colors.white,
                      ),
                      SizedBox(height: 16),
                      CustomButton(
                        colorButton: Color.fromARGB(255, 83, 83, 83),
                        textButton: 'Cambiar contraseña',
                        icon: Icon(Icons.password),
                        onPressed: () {
                          _showChangePasswordDialog(context);
                        },
                      ),
                    ]);
              })),
        ),
      ),
    );
  }

  void _showChangePasswordDialog(
    BuildContext context_,
  ) {
    TextEditingController _miControllerPass = TextEditingController();
    TextEditingController _miControllerPassNew = TextEditingController();
    showDialog(
      barrierDismissible: false,
      context: context_,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: Icon(Icons.password),
          title: Text('Cambiar Contraseña'),
          content: SingleChildScrollView(
            child: Form(
              key: context_.read<ProfileBloc>().formKey,
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
              //child: Text('Cambiar'),
            ),
            CustomButton(
              textButton: 'Cambiar',
              width: 100, colorButton: Color.fromARGB(255, 83, 83, 83),
              onPressed: () {
                context_.read<ProfileBloc>().add(PasswordChangedProfileEvent(
                    _miControllerPass.text,
                    _miControllerPassNew.text,
                    context_));
                //Navigator.pop(context);
              },
              //child: Text('Cambiar'),
            ),
          ],
        );
      },
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

  void _showChangeFileDialog(BuildContext context_, String title, String value,
      String label, void Function()? onPressed, bool isValidatioNum) {
    _miController = TextEditingController(text: value);

    showDialog(
      barrierDismissible: false,
      context: context_,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: Icon(Icons.person),
          title: Text(title),
          content: SingleChildScrollView(
            child: Form(
              key: context_.read<ProfileBloc>().formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _miController,
                    decoration: InputDecoration(labelText: label),
                    validator:
                        isValidatioNum ? _validateInput2 : _validateInput,
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
              //child: Text('Cambiar'),
            ),
            CustomButton(
                textButton: 'Cambiar',
                width: 100,
                colorButton: Color.fromARGB(255, 83, 83, 83),
                onPressed: onPressed
                //child: Text('Cambiar'),
                ),
          ],
        );
      },
    );
  }
}
/**final String? id;
  final String? name;
  final String? lastName;
  final String? lastNameSecond;
  final String? password;
  final String? typeUser;
  final String? userName;
  final String? creatorId;
  final DateTime? registrationDate;
  final DateTime? updateDate;
  final int? status; */
