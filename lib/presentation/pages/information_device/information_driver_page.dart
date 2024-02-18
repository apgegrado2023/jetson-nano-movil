import 'package:flutter/material.dart';
import 'package:flutter_application_prgrado/domain/entities/information_system.dart';
import 'package:flutter_application_prgrado/injection_container.dart';
import 'package:flutter_application_prgrado/presentation/bloc/information_device/information_device_bloc.dart';
import 'package:flutter_application_prgrado/presentation/pages/information_device/widgets/cpu_widget.dart';
import 'package:flutter_application_prgrado/presentation/pages/information_device/widgets/memory_swap_widget.dart';
import 'package:flutter_application_prgrado/presentation/pages/information_device/widgets/memory_widget.dart';
import 'package:flutter_application_prgrado/presentation/pages/information_device/widgets/temp_widget.dart';
import 'package:flutter_application_prgrado/presentation/pages/information_device/widgets/storage_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InformationDevicePage extends StatelessWidget {
  const InformationDevicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InformationDeviceBloc>(
      create: (context) => sl<InformationDeviceBloc>()..add(InitialEvent()),
      child: const InformationDeviceView(),
    );
  }
}

class InformationDeviceView extends StatelessWidget {
  const InformationDeviceView({super.key});

  @override
  Widget build(BuildContext context) {
    print("se construye");
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /*CustomTitle2(
            title: 'Widgets',
            fontSize: 20,
            isBoldTitle: true,
            colorTitle: Colors.white,
          ),*/
          StreamBuilder<SystemInfoEntity>(
            stream: context.read<InformationDeviceBloc>().obtenerDatos(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final systemInfo = snapshot.data!;
                return Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: [
                        Expanded(
                          child: StorageWidget(temp: systemInfo.storageInfo!),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: TemperatureWidget(
                              temp: systemInfo.cpuTemperature!),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 8,
                    ),

                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: MemoryWidget(info: systemInfo.memoryInfo!),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                            child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CpuWidget(cpuUsage: systemInfo.cpuUsage!),
                            SizedBox(
                              height: 8,
                            ),
                            MemorySwapWidget(
                                memoryInfoSwap: systemInfo.memoryInfoSwap!),
                          ],
                        )),
                      ],
                    ),

                    // Agrega más widgets según sea necesario para mostrar la información
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('Error al obtener la información');
              } else {
                return Center(
                    child:
                        CircularProgressIndicator()); // Muestra un indicador de carga mientras se obtiene la información
              }
            },
          ),
        ],
      ),
    );
  }

  /*@override
  void dispose() {
    super.dispose();
    print("dispose");
    sl<PrototypeRepository>().dispose();
    sl<PrototypeRepository>().stopTimer();
  }*/
}
