import 'dart:async';

import 'dart:math';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_prgrado/domain/repository/session_repository.dart';
import 'package:flutter_application_prgrado/domain/repository/user_repository.dart';
import 'package:flutter_application_prgrado/domain/usecases/connection.dart';
import 'package:flutter_application_prgrado/domain/usecases/verification_connection.dart';
import 'package:flutter_application_prgrado/presentation/bloc/login/login_event.dart';
import 'package:flutter_application_prgrado/presentation/bloc/login/login_state.dart';
import 'package:flutter_application_prgrado/presentation/bloc/session/bloc/session_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../../config/routes/routes.dart';
import '../../../config/utils/input_validators.dart';
import '../../../data/models/error_dialog_data.dart';
import '../../../data/models/user.dart';
import '../../widgets/dialogs/dialogs.dart';
import '../../widgets/loading/loading.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SessionBloc sessionBloc;
  final UserRepository userRepository;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final SessionRepository _session;
  LoginBloc(
    this.sessionBloc,
    this.userRepository,
    this._session,
  ) : super(const LoginState()) {
    on<EmailChangedLoginEvent>((event, emit) => _onEmailChanged(event, emit));
    on<PasswordChangedLoginEvent>(
        (event, emit) => _onPasswordChanged(event, emit));
    on<LoginSubmittedLoginEvent>((event, emit) {
      _onLoginSubmitted(event, emit);
    });
  }

  void _onEmailChanged(
    EmailChangedLoginEvent event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(
      email: event.emailString,
    ));
  }

  void _onPasswordChanged(
    PasswordChangedLoginEvent event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(
      password: event.passwordString,
    ));
  }

  Future<Uri?> checkPort(String ipAddress, int port) async {
    Uri url = Uri(scheme: "http", host: ipAddress, port: port);
    //Socket socket = io(url);

    Socket socket = io(url.toString() + '/mi-token_secreto', <String, dynamic>{
      'transports': ['websocket'],
    });

    socket.on('connect', (_) {
      print('Conectado al servidor WebSocket');
    });

    socket.on('disconnect', (_) {
      print('Desconectado del servidor WebSocket');
    });
  }

  Future<void> _onLoginSubmitted(
    LoginSubmittedLoginEvent event,
    Emitter<LoginState> emit,
  ) async {
    try {
      final BuildContext buildContext = event.context;

      final email = state.email;
      final password = state.password;

      if (!isFormValid()) {
        return;
      }

      // Muestra la carga antes de la solicitud asincrónica
      Loading.showText(buildContext, "Iniciando Sesión...");

      final response = await _submit(password!, email!);

      // Cierra la carga después de la solicitud asincrónica
      Loading.close();

      if (response != null) {
        setUserInSession(response);
        await _session.saveToSession(response);
        // Navega a la ruta después de asegurarte de que el contexto esté montado
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (Navigator.canPop(buildContext)) {
            Navigator.pushReplacementNamed(buildContext, Routes.home);
          }
        });
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showErrorMessage(buildContext, event, emit);
        });
      }
    } catch (e) {}
  }

  Future<void> showErrorMessage(
    BuildContext buildContext,
    LoginSubmittedLoginEvent event,
    Emitter<LoginState> emit,
  ) async {
    Dialogs.showErrorMessage(
      buildContext,
      ErrorDialogData(
        "Ocurrió un problema al iniciar sesión, puede que no tenga una cuenta.",
        "Error",
        "Reintentar",
        () async {
          Dialogs.close();
          await _onLoginSubmitted(event, emit); // Llamada al mismo método
        },
        false,
      ),
    );
  }

  bool isFormValid() {
    final isEnableForm = formKey.currentState;
    return isEnableForm != null && formKey.currentState!.validate();
  }

  void setUserInSession(User response) {
    sessionBloc.setUser(response);
  }

  void navigateToHome(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Navigator.canPop(context)) {
        Future.microtask(() {
          Navigator.pushReplacementNamed(context, Routes.home);
        });
      }
    });
  }

  Future<User?> _submit(
    String password,
    String email,
  ) async {
    print("hola");
    return await userRepository.getByParams(email, password);
  }

  String? Function(String?) get validationUserName => (String? value) {
        if (!InputValidators.isRequired(value)) {
          return "No se permite vacios";
        }

        return null;
      };
  String? Function(String?) get validationPassword => (String? value) {
        if (!InputValidators.isRequired(value)) {
          return "No se permite vacios";
        }

        return null;
      };

  /*Future<void> _getDevicesInNetwork() async {
    final Connectivity _connectivity = Connectivity();
    var connectivityResult = await (_connectivity.checkConnectivity());

    if (connectivityResult == ConnectivityResult.wifi) {
      final wifiInfo = await (_connectivity.getfiBSSID());

      // Parse the BSSID to obtain the IP range.
      final ipRange = wifiInfo.split('.').take(3).join('.');

      // Now you can scan the IP range for devices using the methods mentioned earlier.
      // ...
    }
  }*/
}
