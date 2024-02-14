import 'package:flutter/material.dart';
import 'package:flutter_application_prgrado/injection_container.dart';
import 'package:flutter_application_prgrado/presentation/bloc/splash/splash_bloc.dart';
import 'package:flutter_application_prgrado/presentation/widgets/inputs/custom_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashBloc>(
      create: (context) => sl<SplashBloc>()..add(InitialEvent()),
      child: const SplashView(),
    );
  }
}

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocSelector<SplashBloc, SplashState, ConnectionStateServer>(
        selector: (state) => state.connectionStateServer,
        builder: ((context, s) {
          switch (s) {
            case ConnectionStateServer.connected:
              return BlocSelector<SplashBloc, SplashState, String?>(
                  selector: (state) => state.route,
                  builder: ((context, state) {
                    if (state != null) {
                      final routeName = state;

                      Future.delayed(Duration.zero, () {
                        Navigator.pushReplacementNamed(context, routeName);
                      });
                    }
                    return const Center(child: CircularProgressIndicator());
                  }));

            case ConnectionStateServer.loading:
              return Center(
                child: Lottie.asset(
                  'assets/lottie/animation_lny3vsqg.json',
                  width: 200,
                  height: 200,
                ),
              );
            case ConnectionStateServer.disconected:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'assets/lottie/animation_lny44lqi.json',
                      width: 200,
                      height: 200,
                    ),
                    const Text("¡Ups al parecer te desconectaste"),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      textButton: "Volver a conectar",
                      width: 200,
                      onPressed: () {
                        context.read<SplashBloc>().add(ReloadConnectionEvent());
                      },
                    )
                  ],
                ),
              );
            case ConnectionStateServer.failed:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'assets/lottie/animation_lny44lqi.json',
                      width: 200,
                      height: 200,
                    ),
                    const Text("¡Ups al parecer no te puedes conectar!"),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      textButton: "Volver a intentar",
                      width: 200,
                      onPressed: () {},
                    )
                  ],
                ),
              );
            default:
              return const Center(child: CircularProgressIndicator());
          }
        }),
      ),
    );
  }
}
