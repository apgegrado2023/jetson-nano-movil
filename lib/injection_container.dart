import 'package:dio/dio.dart';
import 'package:flutter_application_prgrado/core/constants/constants.dart';
import 'package:flutter_application_prgrado/data/data_sources/local/session/session_service.dart';
import 'package:flutter_application_prgrado/data/data_sources/remote/detection/detection_api_service.dart';
import 'package:flutter_application_prgrado/data/data_sources/remote/device/device_api_service.dart';
import 'package:flutter_application_prgrado/data/data_sources/remote/user/user_api_service.dart';
import 'package:flutter_application_prgrado/data/repository/detection_history_repository_impl.dart';
import 'package:flutter_application_prgrado/data/repository/device_repository_impl.dart';
import 'package:flutter_application_prgrado/data/repository/session_repository_impl.dart';
import 'package:flutter_application_prgrado/domain/repository/detection_history_repository.dart';
import 'package:flutter_application_prgrado/domain/repository/device_repository.dart';
import 'package:flutter_application_prgrado/domain/repository/session_repository.dart';
import 'package:flutter_application_prgrado/domain/repository/user_repository.dart';
import 'package:flutter_application_prgrado/domain/usecases/change_password.dart';
import 'package:flutter_application_prgrado/domain/usecases/check_connection.dart';
import 'package:flutter_application_prgrado/domain/usecases/get_detection_history.dart';
import 'package:flutter_application_prgrado/domain/usecases/get_information_device.dart';
import 'package:flutter_application_prgrado/domain/usecases/get_session.dart';
import 'package:flutter_application_prgrado/domain/usecases/login.dart';
import 'package:flutter_application_prgrado/domain/usecases/remove_session.dart';
import 'package:flutter_application_prgrado/domain/usecases/save_session.dart';
import 'package:flutter_application_prgrado/domain/usecases/save_user.dart';
import 'package:flutter_application_prgrado/domain/usecases/update_filed_user.dart';
import 'package:flutter_application_prgrado/presentation/bloc/detection_history/detection_history_bloc.dart';
import 'package:flutter_application_prgrado/presentation/bloc/home/home_bloc.dart';
import 'package:flutter_application_prgrado/presentation/bloc/information_device/information_device_bloc.dart';
import 'package:flutter_application_prgrado/presentation/bloc/login/login_bloc.dart';
import 'package:flutter_application_prgrado/presentation/bloc/profile/profile_bloc.dart';
import 'package:flutter_application_prgrado/presentation/bloc/register/register_bloc.dart';
import 'package:flutter_application_prgrado/presentation/bloc/session/bloc/session_bloc.dart';
import 'package:flutter_application_prgrado/presentation/bloc/splash/splash_bloc.dart';
import 'package:get_it/get_it.dart';

import 'data/repository/user_repository_impl.dart';

final sl = GetIt.instance;
final dio = Dio();
Future<void> initializeDependencies() async {
  dio.options.baseUrl = ApiBaseURL.url.path;
  dio.options.headers = ApiBaseURL.headers;
  dio.options.connectTimeout = Duration(seconds: 8);
  dio.options.receiveTimeout = Duration(seconds: 8);
  /*Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiBaseURL.url.path,
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 5),
      headers: ApiBaseURL.headers,
    ),
  );
*/
  // Data Sources
  sl.registerSingleton<DeviceApiService>(
    DeviceApiService(dio),
  );
  sl.registerSingleton<UserApiService>(
    UserApiService(dio),
  );

  sl.registerSingleton<DetectionApiService>(
    DetectionApiService(dio),
  );
  sl.registerSingleton<SessionService>(SessionService());

  // Repositories
  sl.registerSingleton<UserRepository>(
    UserRepositoryImpl(sl()),
  );
  sl.registerSingleton<SessionRepository>(
    SessionRepositoryImpl(sl()),
  );

  sl.registerSingleton<DeviceRepository>(
    DeviceRepositoryImpl(sl()),
  );

  sl.registerSingleton<DetectionHistoryRepository>(
    DetectionHistoryRepositoryImpl(sl()),
  );

  // UseCases
  sl.registerSingleton<GetInformationDeviceUseCase>(
    GetInformationDeviceUseCase(sl()),
  );

  sl.registerSingleton<CheckConnectionUseCase>(
    CheckConnectionUseCase(
      sl(),
    ),
  );

  sl.registerSingleton<SaveSessionUseCase>(
    SaveSessionUseCase(
      sl(),
    ),
  );

  sl.registerSingleton<LoginUseCase>(
    LoginUseCase(
      sl(),
    ),
  );
  sl.registerSingleton<SaveUserUseCase>(
    SaveUserUseCase(
      sl(),
    ),
  );

  sl.registerSingleton<GetSessionUseCase>(
    GetSessionUseCase(
      sl(),
    ),
  );

  sl.registerSingleton<RemoveSessionUseCase>(
    RemoveSessionUseCase(
      sl(),
    ),
  );
  sl.registerSingleton<UpdateFileUserUseCase>(
    UpdateFileUserUseCase(
      sl(),
    ),
  );
  sl.registerSingleton<ChangePasswordUseCase>(
    ChangePasswordUseCase(sl()),
  );

  sl.registerSingleton<GetDetectionHistoryUseCase>(
    GetDetectionHistoryUseCase(sl()),
  );
  //Presentation - Bloc

  sl.registerSingleton<SessionBloc>(SessionBloc(sl()));

  sl.registerFactory<SplashBloc>(
    () => SplashBloc(
      sl(),
      sl(),
      sl(),
      sl(),
    ),
  );

  sl.registerFactory<LoginBloc>(
    () => LoginBloc(sl<SessionBloc>(), sl(), sl()),
  );

  sl.registerFactory<RegisterBloc>(
      () => RegisterBloc(sl<SessionBloc>(), sl(), sl()));

  sl.registerFactory<HomeBloc>(() => HomeBloc(
      sl<SessionBloc>(), sl<UserRepository>(), sl<SessionRepository>()));

  sl.registerFactory<InformationDeviceBloc>(
      () => InformationDeviceBloc(sl(), sl()));
  sl.registerFactory<ProfileBloc>(() => ProfileBloc(sl(), sl(), sl(), sl()));
  sl.registerFactory<DetectionHistoryBloc>(() => DetectionHistoryBloc(sl()));
}
