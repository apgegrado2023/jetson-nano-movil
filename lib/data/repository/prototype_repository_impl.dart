import 'dart:async';
import 'dart:math';

import 'package:flutter_application_prgrado/core/resources/data_state.dart';
import 'package:flutter_application_prgrado/data/data_sources/remote/prototype/prototype_api_service.dart';
import 'package:flutter_application_prgrado/data/models/prototype/information_system.dart';
import 'package:flutter_application_prgrado/data/models/prototype/request.dart';
import 'package:flutter_application_prgrado/domain/entities/article.dart';
import 'package:flutter_application_prgrado/domain/repository/prototype_repository.dart';

class PrototypeRepositoryImpl extends PrototypeRepository {
  final PrototypApieService prototypeService;
  Timer? timer;
  StreamController<SystemInfo> systemStreamController =
      StreamController<SystemInfo>.broadcast();
  PrototypeRepositoryImpl(this.prototypeService);
  @override
  Future<bool> isConnect() async {
    return prototypeService.isConnected();
  }

  bool _timerStarted = false;
  @override
  Future<bool> connect() {
    return prototypeService.connect();
  }

  @override
  Stream<SystemInfo> get informationStream {
    if (!_timerStarted) {
      _startTimer();
      _timerStarted = true;
    }
    return systemStreamController.stream;
  }

  void _startTimer() {
    print("se inicia el timer");
    systemStreamController = StreamController.broadcast();

    timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      print("se ejecuta timer");
      final info = await getInformationDevice();
      if (info != null) {
        systemStreamController.sink.add(info);
      }
    });
  }

  @override
  void dispose() {
    _timerStarted = false;
    systemStreamController.close();
    timer?.cancel(); // Asegúrate de cancelar el Timer aquí
  }

  @override
  void stopTimer() {
    timer?.cancel();
  }

  String generateUniqueCode() {
    final random = Random();
    final uniqueCode = random.nextInt(90000) + 10000;
    return uniqueCode.toString();
  }

  @override
  Future<SystemInfo?> getInformationDevice() async {
    try {
      final uniqueCode = generateUniqueCode();
      final request = RequestService(
        type: "service_info_device",
        command: uniqueCode,
      );

      final response = await prototypeService.request(request);

      if (response.responseStatus == StatusResponse.failed) {
        return null;
      }
      final info = SystemInfo.fromJson(response.data!);

      return info;
    } catch (e) {
      return null;
    }
  }
}
