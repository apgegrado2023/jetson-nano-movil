/*import 'package:flutter/material.dart';
import 'package:flutter_application_prgrado/presentation/bloc/session/bloc/session_event.dart';
import 'package:flutter_application_prgrado/presentation/bloc/splash/splash_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../injection_container.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashBloc, SplashState>(
        bloc: sl<SplashBloc>()..add(InitialEvent()),
        listener: (context, state) {
          final routeName = state.route;

          if (routeName != null) {
            Navigator.pushReplacementNamed(context, routeName);
          }
        },
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
*/

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_prgrado/presentation/bloc/session/bloc/session_event.dart';
import 'package:flutter_application_prgrado/presentation/bloc/splash/splash_bloc.dart';
import 'package:flutter_application_prgrado/presentation/widgets/inputs/custom_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';

import '../../../injection_container.dart';

class SplashPage extends StatelessWidget {
  SplashPage({Key? key}) : super(key: key);
  String _connectionStatus = 'Unknown';
  String _getStatusString(ConnectivityResult status) {
    switch (status) {
      case ConnectivityResult.mobile:
        return 'Conectado a través de datos móviles';
      case ConnectivityResult.wifi:
        return 'Conectado a través de Wi-Fi';
      case ConnectivityResult.none:
        return 'Sin conexión';
      default:
        return 'Desconocido';
    }
  }

  @override
  Widget build(BuildContext context) {
    Connectivity().onConnectivityChanged.listen((result) {
      //setState(() {
      _connectionStatus = _getStatusString(result);
      //});
    });

    final bloc = sl<SplashBloc>();

    return Scaffold(
      body: BlocSelector<SplashBloc, SplashState, ConnectionStateServer>(
        bloc: bloc..add(InitialEvent()),
        selector: (state) => state.connectionStateServer,
        builder: ((context, s) {
          switch (s) {
            case ConnectionStateServer.connected:
              return BlocSelector<SplashBloc, SplashState, String?>(
                  bloc: bloc,
                  selector: (state) => state.route,
                  builder: ((context, state) {
                    if (state != null) {
                      final routeName = state;

                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.pushReplacementNamed(context, routeName);
                      });
                    }
                    return const Center(child: CircularProgressIndicator());
                  }));

            case ConnectionStateServer.loading:
              return Center(
                child: Lottie.asset(
                  'assets/lottie/animation_lny3vsqg.json', // Ruta a tu archivo JSON de animación
                  width: 200, // Ajusta el ancho según tus preferencias
                  height: 200, // Ajusta la altura según tus preferencias
                ),
              );
            case ConnectionStateServer.disconected:
              return const Center(child: CircularProgressIndicator());
            case ConnectionStateServer.failed:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'assets/lottie/animation_lny44lqi.json', // Ruta a tu archivo JSON de animación
                      width: 200, // Ajusta el ancho según tus preferencias
                      height: 200, // Ajusta la altura según tus preferencias
                    ),
                    const Text("¡Ups al parecer no estas conectado!"),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      textButton: "Recargar",
                      width: 200,
                      onPressed: () {},
                    )
                  ],
                ),
              );
            default:
              return Center(child: CircularProgressIndicator());
          }
        }),
      ),
    );
  }
}
