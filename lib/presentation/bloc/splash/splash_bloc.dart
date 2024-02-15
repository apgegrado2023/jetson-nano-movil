import 'dart:async';
import 'package:flutter_application_prgrado/config/routes/routes.dart';
import 'package:flutter_application_prgrado/core/resources/data_state.dart';
import 'package:flutter_application_prgrado/domain/entities/user.dart';
import 'package:flutter_application_prgrado/domain/usecases/get_session.dart';
import 'package:flutter_application_prgrado/presentation/bloc/session/bloc/session_event.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_prgrado/domain/repository/session_repository.dart';
import 'package:flutter_application_prgrado/domain/usecases/check_connection.dart';
import 'package:flutter_application_prgrado/domain/usecases/get_information_device.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../session/bloc/session_bloc.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final SessionBloc sessionBloc;
  final GetInformationDeviceUseCase _getInformationDeviceUseCase;
  final CheckConnectionUseCase _checkConnectionUseCase;
  final GetSessionUseCase _getSessionUseCase;

  SplashBloc(
    this.sessionBloc,
    this._getInformationDeviceUseCase,
    this._checkConnectionUseCase,
    this._getSessionUseCase,
  ) : super(SplashState()) {
    on<ChangeRoute>(onChangeRoute);
    on<InitialEvent>(init);
    on<ReloadConnectionEvent>(reloadConnection);
  }

  Future<void> reloadConnection(
    ReloadConnectionEvent event,
    Emitter<SplashState> emit,
  ) async {
    final dataState = await _getInformationDeviceUseCase();
    if (dataState is DataSuccess) {
      print(dataState.data!);
    }

    /*final data = await _checkConnection2UseCase();
    if (data is DataSuccess) {
      print(data.data);
    } else {
      print(data.data);
    }*/
    /*final dio = Dio(); // With default `Options`.
    //dio.options.baseUrl = 'https://api.pub.dev';
    dio.options.connectTimeout = Duration(seconds: 5);
    dio.options.receiveTimeout = Duration(seconds: 5);
    dio.options.sendTimeout = Duration(seconds: 5);

    try {
      final response = await dio.get('http://192.168.3.58:5000/device');
      print(response);
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
      }
    } catch (e) {
      print(e);
    }*/

    //await fetchDataWithTimeout();
    //verificarConexion();

    try {
      //await getLoginDetails();

    } catch (e) {
      print(e.toString());
    }
  }

  /*Future<bool> getLoginDetails() async {
    Dio? dio;

    if (dio == null) {
      BaseOptions options = new BaseOptions(
          baseUrl: "http://192.168.3.58:5000",
          receiveDataWhenStatusError: true,
          connectTimeout: Duration(seconds: 5), // 60 seconds
          receiveTimeout: Duration(seconds: 5) // 60 seconds
          );

      dio = new Dio(options);
    }
    try {
      await dio.get('/device');
      //final LoginResponse loginResponse = LoginResponse.fromJson(response.data);
      return true;
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionTimeout) {
        //throw Exception("Connection  Timeout Exception");
      }
      //throw Exception(ex.message);
      return false;
    }
  }*/

  Future<void> fetchDataWithTimeout() async {
    try {
      final client = http.Client();
      final response = await client
          .get(
            Uri.parse('http://192.168.3.58:5000/device'),
          )
          .timeout(Duration(seconds: 5));

      print(response.body);
    } on TimeoutException catch (e) {
      print('La solicitud excedió el tiempo de espera: $e');
    } on http.ClientException catch (e) {
      print('Error de cliente HTTP: $e');
    } catch (e) {
      print('Otro error: $e');
    }
  }

  Future<bool> checkConnection() async {
    final checkResponse = await _checkConnectionUseCase.call();
    if (checkResponse is DataSuccess) {
      return checkResponse.data!;
    } else {
      return false;
    }
  }

  Future<UserEntity?> getSession() async {
    final userResponse = await _getSessionUseCase();
    if (userResponse is DataSuccess) {
      return userResponse.data;
    } else {
      return null;
    }
  }

  Future<void> init(InitialEvent event, Emitter<SplashState> emit) async {
    print("iniciando...");
    emit(state.copyWith(connectionStateServer: ConnectionStateServer.loading));

    final isConnected = await checkConnection();

    if (!isConnected) {
      /*emit(SplashState(
        connectionStateServer: ConnectionStateServer.failed,
      ));*/
      print("No conectado...");
      //return;
    }
    print("Conectado...");
    emit(state.copyWith(
      connectionStateServer: ConnectionStateServer.connected,
    ));

    final user = await getSession();

    String routeName = user == null ? Routes.login : Routes.home;

    if (user != null) {
      sessionBloc.add(SaveSessionEvent(user));
      print("Session encontrada");
    }
    print("No hyay sesion");
    add(ChangeRoute(routeName));
  }

  /*Future<void> initialEvent(
    InitialEvent event,
    Emitter<SplashState> emit,
  ) async {
    print("se llama");
    final isConnectedServer = await verificationConnectionUseCase();

    emit(state.copyWith(
      connectionStateServer: ConnectionStateServer.loading,
    ));
    print(isConnectedServer);

    if (!isConnectedServer) {
      final isConnected = await connectionUseCase();

      if (!isConnected) {
        emit(SplashState(connectionStateServer: ConnectionStateServer.failed));
        log("no hay servidor");
        return;
      } else {
        emit(state.copyWith(
          connectionStateServer: ConnectionStateServer.connected,
        ));
        log("si hay servidor");
      }

      String routeName;

      final user = await _session.getToSession();

      if (user == null) {
        routeName = Routes.login;
      } else {
        routeName = Routes.home;
        sessionBloc.add(ChangeSessionSessionEvent(user));
      }
      add(ChangeRoute(routeName));
    }
  }
*/
  void onChangeRoute(ChangeRoute event, Emitter<SplashState> emit) {
    print("comida");
    emit(state.copyWith(route: event.route));
  }
}
