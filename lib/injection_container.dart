import 'package:dio/dio.dart';
import 'package:flutter_application_prgrado/data/data_sources/remote/prototype/data_source_prototype_service.dart';
import 'package:flutter_application_prgrado/data/data_sources/remote/prototype/device_api_service.dart';
import 'package:flutter_application_prgrado/data/data_sources/remote/prototype/prototype_api_service.dart';
import 'package:flutter_application_prgrado/data/repository/device_repository_impl.dart';
import 'package:flutter_application_prgrado/data/repository/prototype_device_repository_impl.dart';
import 'package:flutter_application_prgrado/data/repository/session_repository_impl.dart';
import 'package:flutter_application_prgrado/domain/repository/device_repository.dart';
import 'package:flutter_application_prgrado/domain/repository/prototype_device_repository.dart';
import 'package:flutter_application_prgrado/domain/repository/prototype_repository.dart';
import 'package:flutter_application_prgrado/domain/repository/session_repository.dart';
import 'package:flutter_application_prgrado/domain/repository/user_repository.dart';
import 'package:flutter_application_prgrado/domain/usecases/check_connection.dart';
import 'package:flutter_application_prgrado/domain/usecases/check_connection2.dart';
import 'package:flutter_application_prgrado/domain/usecases/connection.dart';
import 'package:flutter_application_prgrado/domain/usecases/connection_prototype.dart';
import 'package:flutter_application_prgrado/domain/usecases/connection_prototype_verification.dart';
import 'package:flutter_application_prgrado/domain/usecases/get_information_device.dart';
import 'package:flutter_application_prgrado/domain/usecases/get_information_device2.dart';
import 'package:flutter_application_prgrado/domain/usecases/get_information_prototype.dart';
import 'package:flutter_application_prgrado/domain/usecases/verification_connection.dart';
import 'package:flutter_application_prgrado/presentation/bloc/home/home_bloc.dart';
import 'package:flutter_application_prgrado/presentation/bloc/information_device/information_device_bloc.dart';
import 'package:flutter_application_prgrado/presentation/bloc/login/login_bloc.dart';
import 'package:flutter_application_prgrado/presentation/bloc/register/register_bloc.dart';
import 'package:flutter_application_prgrado/presentation/bloc/session/bloc/session_bloc.dart';
import 'package:flutter_application_prgrado/presentation/bloc/side_menu/side_menu_bloc.dart';
import 'package:flutter_application_prgrado/presentation/bloc/splash/splash_bloc.dart';
import 'package:get_it/get_it.dart';

import 'data/repository/prototype_repository_impl.dart';
import 'data/repository/user_repository_impl.dart';

final sl = GetIt.instance;
final dio = Dio();
Future<void> initializeDependencies() async {
  //Dio

  dio.options.connectTimeout = Duration(seconds: 5);
  dio.options.receiveTimeout = Duration(seconds: 5);
  dio.options.sendTimeout = Duration(seconds: 5);
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        // Do something before request is sent.
        // If you want to resolve the request with custom data,
        // you can resolve a `Response` using `handler.resolve(response)`.
        // If you want to reject the request with a error message,
        // you can reject with a `DioException` using `handler.reject(dioError)`.
        return handler.next(options);
      },
      onResponse: (Response response, ResponseInterceptorHandler handler) {
        // Do something with response data.
        // If you want to reject the request with a error message,
        // you can reject a `DioException` object using `handler.reject(dioError)`.
        print(response);
        return handler.resolve(response);
      },
      onError: (DioException error, ErrorInterceptorHandler handler) {
        // Do something with response error.
        // If you want to resolve the request with some custom data,
        // you can resolve a `Response` object using `handler.resolve(response)`.
        print(error);
        return handler.resolve(Response(
            data: "", statusCode: 404, requestOptions: RequestOptions()));
      },
    ),
  );
  sl.registerSingleton<Dio>(dio);

  // Data Sources
  /*sl.registerSingleton<PrototypApieService>(
    PrototypApieService(),
  );*/
  /*sl.registerSingleton<DataSourcePrototypeService>(
    DataSourcePrototypeService(),
  );*/

  sl.registerSingleton<DeviceApiService2>(
    DeviceApiService2(),
  );

  sl.registerSingleton<DeviceApiService>(
    DeviceApiService(
      sl(),
    ),
  );

  // Repositories
  /*sl.registerSingleton<PrototypeRepository>(
      PrototypeRepositoryImpl(sl<PrototypApieService>()));*/
  sl.registerFactory<UserRepository>(() => UserRepositoryImpl());
  sl.registerFactory<SessionRepository>(
      () => SessionRepositoryImpl(sl<UserRepository>()));

  /*sl.registerSingleton<PrototypeDeviceRepository>(
    PrototypeDeviceRepositoryImpl(
      sl<DataSourcePrototypeService>(),
    ),
  );*/

  sl.registerSingleton<DeviceRepository>(DeviceRepositoryImpl(
    sl(),
    sl(),
  ));

  // UseCases
  /*sl.registerFactory<VerificationConnectionUseCase>(
      () => VerificationConnectionUseCase(sl<PrototypeRepository>()));
  sl.registerFactory<ConnectionUseCase>(
      () => ConnectionUseCase(sl<PrototypeRepository>()));

  sl.registerFactory<ConnectionPrototypeUseCase>(
    () => ConnectionPrototypeUseCase(
      sl<PrototypeDeviceRepository>(),
    ),
  );

  sl.registerFactory<ConnectionProtypeVerificationUseCase>(
    () => ConnectionProtypeVerificationUseCase(
      sl<PrototypeDeviceRepository>(),
    ),
  );

  sl.registerFactory<GetInformationPrototypeUseCase>(
    () => GetInformationPrototypeUseCase(
      sl<DeviceRepository>(),
    ),
  );
*/
  sl.registerSingleton<GetInformationDeviceUseCase>(
    GetInformationDeviceUseCase(
      sl(),
    ),
  );

  sl.registerSingleton<GetInformationDevice2UseCase>(
    GetInformationDevice2UseCase(
      sl(),
    ),
  );

  sl.registerSingleton<CheckConnectionUseCase>(
    CheckConnectionUseCase(
      sl(),
    ),
  );

  sl.registerSingleton<CheckConnection2UseCase>(
    CheckConnection2UseCase(
      sl(),
    ),
  );

  //Presentation - Bloc

  sl.registerSingleton<SessionBloc>(SessionBloc());

  /*sl.registerFactory<SideMenuBloc>(() => SideMenuBloc(sl<SessionBloc>()));*/

  sl.registerFactory<SplashBloc>(
    () => SplashBloc(
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
    ),
  );

  /*sl.registerFactory<LoginBloc>(() => LoginBloc(
      sl<SessionBloc>(), sl<UserRepository>(), sl<SessionRepository>()));*/

  /*sl.registerFactory<RegisterBloc>(() => RegisterBloc(
      sl<SessionBloc>(), sl<UserRepository>(), sl<SessionRepository>()));

  sl.registerFactory<HomeBloc>(() => HomeBloc(
      sl<SessionBloc>(), sl<UserRepository>(), sl<SessionRepository>()));

  sl.registerFactory<InformationDeviceBloc>(() => InformationDeviceBloc());*/
}
