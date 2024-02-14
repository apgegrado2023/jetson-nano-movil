import 'package:flutter_application_prgrado/core/resources/data_state.dart';
import 'package:flutter_application_prgrado/data/models/prototype/information_system.dart';
import 'package:flutter_application_prgrado/domain/entities/article.dart';

abstract class PrototypeRepository {
  // API methods
  Future<bool> isConnect();
  Future<bool> connect();
  Stream<SystemInfoModel> get informationStream;
  void dispose(); // Método para cerrar el StreamController
  void stopTimer();
  Future<SystemInfoModel?>
      getInformationDevice(); // Declaración del método para obtener información
}
