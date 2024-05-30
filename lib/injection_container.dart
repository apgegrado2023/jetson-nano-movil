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
import 'package:flutter_application_prgrado/domain/usecases/getUriCameras.dart';
import 'package:flutter_application_prgrado/domain/usecases/get_detection_history.dart';
import 'package:flutter_application_prgrado/domain/usecases/get_information_device.dart';
import 'package:flutter_application_prgrado/domain/usecases/get_session.dart';
import 'package:flutter_application_prgrado/domain/usecases/login.dart';
import 'package:flutter_application_prgrado/domain/usecases/remove_session.dart';
import 'package:flutter_application_prgrado/domain/usecases/save_session.dart';
import 'package:flutter_application_prgrado/domain/usecases/save_user.dart';
import 'package:flutter_application_prgrado/domain/usecases/update_filed_user.dart';
import 'package:flutter_application_prgrado/presentation/pages/home/BLOC/home_bloc.dart';
import 'package:flutter_application_prgrado/presentation/pages/user_profile/bloc/profile_bloc.dart';
import 'package:flutter_application_prgrado/presentation/pages/video_camera/cubit/video_camera_cubit.dart';
import 'package:flutter_application_prgrado/presentation/session/bloc/session_bloc.dart';
import 'package:flutter_application_prgrado/presentation/pages/splash/splash/splash_bloc.dart';
import 'package:flutter_application_prgrado/presentation/pages/detection_history/cubit/detection_history_cubit.dart';
import 'package:flutter_application_prgrado/presentation/pages/information_device/cubit/information_device_cubit.dart';
import 'package:flutter_application_prgrado/presentation/pages/login/cubit/login_cubit.dart';
import 'package:flutter_application_prgrado/presentation/pages/register/cubit/register_cubit.dart';
import 'package:get_it/get_it.dart';

import 'data/repository/user_repository_impl.dart';

final sl = GetIt.instance;
final dio = Dio();
Future<void> initializeDependencies() async {
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
  sl.registerSingleton<DeviceApiService>(DeviceApiService(dio));
  sl.registerSingleton<UserApiService>(UserApiService(dio));
  sl.registerSingleton<DetectionApiService>(DetectionApiService(dio));
  sl.registerSingleton<SessionService>(SessionService());

  // Repositories
  sl.registerSingleton<UserRepository>(UserRepositoryImpl(sl()));
  sl.registerSingleton<SessionRepository>(SessionRepositoryImpl(sl()));
  sl.registerSingleton<DeviceRepository>(DeviceRepositoryImpl(sl()));
  sl.registerSingleton<DetectionHistoryRepository>(
      DetectionHistoryRepositoryImpl(sl()));

  // UseCases
  sl.registerSingleton<GetInformationDeviceUseCase>(
      GetInformationDeviceUseCase(sl()));
  sl.registerSingleton<CheckConnectionUseCase>(CheckConnectionUseCase(sl()));
  sl.registerSingleton<SaveSessionUseCase>(SaveSessionUseCase(sl()));
  sl.registerSingleton<LoginUseCase>(LoginUseCase(sl()));
  sl.registerSingleton<SaveUserUseCase>(SaveUserUseCase(sl()));
  sl.registerSingleton<GetSessionUseCase>(GetSessionUseCase(sl()));
  sl.registerSingleton<RemoveSessionUseCase>(RemoveSessionUseCase(sl()));
  sl.registerSingleton<UpdateFileUserUseCase>(UpdateFileUserUseCase(sl()));
  sl.registerSingleton<ChangePasswordUseCase>(ChangePasswordUseCase(sl()));
  sl.registerSingleton<GetDetectionHistoryUseCase>(
      GetDetectionHistoryUseCase(sl()));

  sl.registerSingleton<GetUriUseCase>(GetUriUseCase(sl()));

  //Presentation - Bloc
  sl.registerSingleton<SessionBloc>(SessionBloc(sl()));
  sl.registerFactory<SplashBloc>(() => SplashBloc(sl(), sl(), sl(), sl()));
  sl.registerFactory<HomeBloc>(() => HomeBloc(sl(), sl()));
  sl.registerFactory<ProfileBloc>(() => ProfileBloc(sl(), sl(), sl(), sl()));
  sl.registerFactory<DetectionHistoryCubit>(
      () => DetectionHistoryCubit(sl(), sl()));

  //CUBITS
  sl.registerFactory<InformationDeviceCubit>(
      () => InformationDeviceCubit(sl()));
  sl.registerFactory<LoginCubit>(() => LoginCubit(sl(), sl()));
  sl.registerFactory<RegisterCubit>(() => RegisterCubit(sl(), sl()));
  sl.registerFactory<VideoCameraCubit>(() => VideoCameraCubit(sl(), sl()));
}
