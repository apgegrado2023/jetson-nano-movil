import 'dart:async';
import 'dart:developer';

import 'package:flutter_application_prgrado/config/utils/generate_code.dart';
import 'package:flutter_application_prgrado/data/data_sources/remote/prototype/data_source_prototype_service.dart';
import 'package:flutter_application_prgrado/data/models/prototype/information_system.dart';
import 'package:flutter_application_prgrado/data/models/prototype/request.dart';
import 'package:flutter_application_prgrado/domain/repository/information_prototype_repository.dart';

class InformationPrototypeRepositoryImpl
    implements InformationPrototypeRepository {
  InformationPrototypeRepositoryImpl(this.dataSourcePrototypeService);

  final DataSourcePrototypeService dataSourcePrototypeService;
  Timer? timer;
  StreamController<SystemInfo> streamControllerSystem =
      StreamController<SystemInfo>.broadcast();
  bool _timerStarted = false;

  @override
  Stream<SystemInfo> get informationStream {
    if (!_timerStarted) {
      _startTimer();
      _timerStarted = true;
    }
    return streamControllerSystem.stream;
  }

  void _startTimer() {
    streamControllerSystem = StreamController.broadcast();
    timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      final info = await getInformation();
      if (info != null) {
        streamControllerSystem.sink.add(info);
      }
    });
  }

  @override
  void dispose() {
    _timerStarted = false;
    streamControllerSystem.close();
    timer?.cancel();
  }

  @override
  void stopTimer() {
    timer?.cancel();
  }

  @override
  Future<SystemInfo?> getInformation() async {
    try {
      final uniqueCode = GenerateCode.generateUniqueCode();
      final request = RequestService(
        type: "service_info_device",
        command: uniqueCode,
      );

      final response = await dataSourcePrototypeService.request(request);

      if (response.responseStatus == StatusResponse.failed ||
          response.responseStatus == StatusResponse.serverNotConnected ||
          response.responseStatus == StatusResponse.problem) {
        return null;
      }
      final info = SystemInfo.fromJson(response.data!);
      return info;
    } catch (e) {
      log('$e');
      return null;
    }
  }
}
