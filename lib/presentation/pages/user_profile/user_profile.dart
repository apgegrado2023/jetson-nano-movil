import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_prgrado/domain/entities/user.dart';
import 'package:flutter_application_prgrado/presentation/pages/user_profile/bloc/profile_bloc.dart';
import 'package:flutter_application_prgrado/presentation/pages/user_profile/widgets/dialog_field.dart';
import 'package:flutter_application_prgrado/presentation/pages/user_profile/widgets/dialog_password.dart';
import 'package:flutter_application_prgrado/presentation/pages/user_profile/widgets/item_profile.dart';
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

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfileBloc>();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 24, 24, 24),
      appBar: AppBar(
        title: Text(
          'Perfil de Usuario',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color.fromARGB(255, 24, 24, 24),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: BlocSelector<ProfileBloc, ProfileState, UserEntity?>(
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
                      ItemProfile(
                        title: "Nombre:",
                        text: userEntity.name!,
                        icon: Icon(Icons.person).icon!,
                        onPressed: () {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (_) {
                              return BlocProvider.value(
                                value: context.read<ProfileBloc>(),
                                child: DialogField(
                                  title: 'Cambiar Nombre',
                                  value: userEntity.name,
                                  label: 'Nombres',
                                  isValidatioNum: true,
                                  onPressed: (value) {
                                    bloc.add(NameChangedProfileEvent(
                                        value, context));
                                  },
                                ),
                              );
                            },
                          );
                        },
                      ),
                      SizedBox(height: 16),
                      ItemProfile(
                        title: "Apellidos:",
                        text: userEntity.lastName,
                        icon: Icon(Icons.person).icon!,
                        onPressed: () {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (_) {
                              return BlocProvider.value(
                                value: context.read<ProfileBloc>(),
                                child: DialogField(
                                  title: 'Cambiar Apellidos',
                                  value: userEntity.lastName,
                                  label: 'Apellidos',
                                  isValidatioNum: true,
                                  onPressed: (value) {
                                    bloc.add(LastNameChangedProfileEvent(
                                        value, context));
                                  },
                                ),
                              );
                            },
                          );
                        },
                      ),
                      SizedBox(height: 16),
                      ItemProfile(
                        title: "Usuario:",
                        text: userEntity.userName,
                        icon: Icon(Icons.person).icon!,
                        onPressed: () {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (_) {
                              return BlocProvider.value(
                                value: context.read<ProfileBloc>(),
                                child: DialogField(
                                  title: 'Cambiar Usuario',
                                  value: userEntity.userName,
                                  label: 'Usuario',
                                  isValidatioNum: true,
                                  onPressed: (value) {
                                    bloc.add(UserNameChangedProfileEvent(
                                        value, context));
                                  },
                                ),
                              );
                            },
                          );
                        },
                      ),
                      SizedBox(height: 16),
                      Divider(
                        color: Colors.white,
                      ),
                      SizedBox(height: 16),
                      CustomButton(
                        colorTextButton: Colors.white,
                        colorButton: Color.fromARGB(255, 83, 83, 83),
                        textButton: 'Cambiar contraseña',
                        icon: Icon(
                          Icons.password,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (_) {
                              return BlocProvider.value(
                                value: context.read<ProfileBloc>(),
                                child: DialogPassword(),
                              );
                            },
                          );
                        },
                      ),
                    ]);
              })),
        ),
      ),
    );
  }
}
