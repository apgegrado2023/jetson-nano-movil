import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_prgrado/domain/repository/prototype_repository.dart';
import 'package:flutter_application_prgrado/injection_container.dart';
import 'package:flutter_application_prgrado/presentation/pages/information_device/widgets/cpu_widget.dart';
import 'package:flutter_application_prgrado/presentation/pages/information_device/widgets/memory_widget.dart';
import 'package:flutter_application_prgrado/presentation/pages/information_device/widgets/storage_widget%20copy.dart';
import 'package:flutter_application_prgrado/presentation/pages/information_device/widgets/temp_widget.dart';
import 'package:flutter_application_prgrado/presentation/widgets/text/custom_title.dart';
import 'package:lottie/lottie.dart';

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
        body: SingleChildScrollView(
      child: Container(
        color: Color.fromARGB(255, 241, 241, 241),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  tileMode: TileMode.repeated,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 57, 74, 226),
                    Color.fromARGB(255, 74, 64, 161),
                    Color.fromARGB(255, 26, 200, 253)
                  ],
                ),
              ),
              padding: EdgeInsets.only(top: 30),
              //color: Color.fromARGB(255, 57, 74, 226),
              child: Lottie.asset(
                'assets/lottie/animation_lod3volp.json', // Ruta a tu archivo JSON de animación
                width: 250, // Ajusta el ancho según tus preferencias
                height: 250, // Ajusta la altura según tus preferencias
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTitle2(
                    title: 'Información del dispositivo',
                    subTitle: "Información del prototipo en tiempo real.",
                    fontSize: 25,
                    isBoldTitle: true,
                    colorTitle: Color.fromARGB(255, 74, 64, 161),
                    colorSubTitle: Colors.black54,
                  ),
                  StreamBuilder<SystemInfo>(
                    stream: sl<PrototypeRepository>()
                        .informationStream, // systemInfoService.informationStream, // Asigna tu stream aquí
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final systemInfo = snapshot.data!;
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            TempWidget(temp: systemInfo.cpuTemperature),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: CpuWidget(
                                        cpuUsage: systemInfo.cpuUsage)),
                                SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                    child: StorageWidget(
                                        temp: systemInfo.cpuTemperature))
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            MemoryWidget(info: systemInfo.memoryInfo),
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
                ],
              ),
            )
          ],
        ),
      ),
    ));

    _widgetsd() {}
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
    sl<PrototypeRepository>().dispose();
    sl<PrototypeRepository>().stopTimer();
  }
}
