import '../../data/models/prototype/information_system.dart';

abstract class InformationPrototypeRepository {
  Stream<SystemInfo> get informationStream;
  void dispose();
  void stopTimer();
  Future<SystemInfo?> getInformation();
}
