import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_prgrado/domain/repository/prototype_repository.dart';
import 'package:flutter_application_prgrado/injection_container.dart';

import '../../../data/models/prototype/information_system.dart';

class InformationDevicePage extends StatefulWidget {
  const InformationDevicePage({super.key});

  @override
  State<InformationDevicePage> createState() => _InformationDevicePageState();
}

class _InformationDevicePageState extends State<InformationDevicePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<SystemInfo>(
        stream: sl<PrototypeRepository>()
            .informationStream, // systemInfoService.informationStream, // Asigna tu stream aquí
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final systemInfo = snapshot.data!;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Temperatura CPU: ${systemInfo.cpuTemperature}'),
                Text('Almacenamiento Total: ${systemInfo.totalStorage}'),
                Text('Uso de CPU: ${systemInfo.cpuUsage}'),
                Text('Memoria Total: ${systemInfo.memoryInfo.total}'),
                // Agrega más widgets según sea necesario para mostrar la información
              ],
            );
          } else if (snapshot.hasError) {
            return Text('Error al obtener la información');
          } else {
            return CircularProgressIndicator(); // Muestra un indicador de carga mientras se obtiene la información
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
    sl<PrototypeRepository>().dispose();
    sl<PrototypeRepository>().stopTimer();
  }
}
