import 'package:flutter_application_prgrado/data/data_sources/remote/prototype/prototype_api_service.dart';
import 'package:flutter_application_prgrado/data/repository/session_repository_impl.dart';
import 'package:flutter_application_prgrado/domain/repository/prototype_repository.dart';
import 'package:flutter_application_prgrado/domain/repository/session_repository.dart';
import 'package:flutter_application_prgrado/domain/repository/user_repository.dart';
import 'package:flutter_application_prgrado/domain/usecases/connection.dart';
import 'package:flutter_application_prgrado/domain/usecases/verification_connection.dart';
import 'package:flutter_application_prgrado/presentation/bloc/home/home_bloc.dart';
import 'package:flutter_application_prgrado/presentation/bloc/login/login_bloc.dart';
import 'package:flutter_application_prgrado/presentation/bloc/register/register_bloc.dart';
import 'package:flutter_application_prgrado/presentation/bloc/session/bloc/session_bloc.dart';
import 'package:flutter_application_prgrado/presentation/bloc/side_menu/side_menu_bloc.dart';
import 'package:flutter_application_prgrado/presentation/bloc/splash/splash_bloc.dart';
import 'package:get_it/get_it.dart';

import 'data/repository/prototype_repository_impl.dart';
import 'data/repository/user_repository_impl.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Data Sources
  sl.registerSingleton<PrototypApieService>(PrototypApieService());

  // Repositories
  sl.registerSingleton<PrototypeRepository>(
      PrototypeRepositoryImpl(sl<PrototypApieService>()));
  sl.registerFactory<UserRepository>(
      () => UserRepositoryImpl(sl<PrototypApieService>()));
  sl.registerFactory<SessionRepository>(
      () => SessionRepositoryImpl(sl<UserRepository>()));

  // UseCases
  sl.registerFactory<VerificationConnectionUseCase>(
      () => VerificationConnectionUseCase(sl<PrototypeRepository>()));
  sl.registerFactory<ConnectionUseCase>(
      () => ConnectionUseCase(sl<PrototypeRepository>()));

  //Presentation - Bloc

  sl.registerSingleton<SessionBloc>(SessionBloc());

  sl.registerFactory<SideMenuBloc>(() => SideMenuBloc(sl<SessionBloc>()));

  sl.registerFactory<SplashBloc>(() => SplashBloc(
      sl<SessionBloc>(),
      sl<VerificationConnectionUseCase>(),
      sl<ConnectionUseCase>(),
      sl<SessionRepository>()));

  sl.registerFactory<LoginBloc>(() => LoginBloc(
      sl<SessionBloc>(), sl<UserRepository>(), sl<SessionRepository>()));

  sl.registerFactory<RegisterBloc>(() => RegisterBloc(
      sl<SessionBloc>(), sl<UserRepository>(), sl<SessionRepository>()));

  sl.registerFactory<HomeBloc>(() => HomeBloc(
      sl<SessionBloc>(), sl<UserRepository>(), sl<SessionRepository>()));
}
