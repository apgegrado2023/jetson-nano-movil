import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_prgrado/config/routes/app_routes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'config/routes/routes.dart';
import 'config/utils/my_colors.dart';
import 'injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDependencies();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Sytem security driver",
      theme: ThemeData(
        textTheme: GoogleFonts.ubuntuTextTheme(),
        primarySwatch: CustomColorPrimary().materialColor,
      ),
      supportedLocales: const [
        Locale('en', ''),
        Locale('ar', ''), // arabic, no country code
      ],
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRoutes.onGenerateRoutes,
      initialRoute: Routes.splash,
    );
  }
}
/**import 'package:flutter_application_prgrado/data/data_sources/remote/prototype/prototype_connection.dart';
import 'package:flutter_application_prgrado/domain/repository/prototype_repository.dart';
import 'package:flutter_application_prgrado/domain/usecases/verification_connection.dart';
import 'package:flutter_application_prgrado/presentation/bloc/login/login_bloc.dart';
import 'package:flutter_application_prgrado/presentation/bloc/register/register_bloc.dart';
import 'package:flutter_application_prgrado/presentation/bloc/session/bloc/session_bloc.dart';
import 'package:flutter_application_prgrado/presentation/bloc/splash/splash_bloc.dart';
import 'package:get_it/get_it.dart';

import 'data/repository/prototype_repository_impl.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  //Data Sources
  sl.registerFactory<PrototypeService>(() => PrototypeService());

  //Repositories
  sl.registerFactory<PrototypeRepository>(
    () => PrototypeRepositoryImpl(
      sl<PrototypeService>(),
    ),
  );

  //UseCases
  sl.registerFactory<VerificationConnectionUseCase>(
    () => VerificationConnectionUseCase(
      sl<PrototypeRepository>(),
    ),
  );

  sl.registerFactory<SessionBloc>(() => SessionBloc());

  sl.registerFactory<SplashBloc>(() => SplashBloc(sl<SessionBloc>()));
  sl.registerFactory<LoginBloc>(() => LoginBloc(sl<SessionBloc>()));
  sl.registerFactory<RegisterBloc>(() => RegisterBloc(sl<SessionBloc>()));
}
 */