import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_prgrado/config/utils/my_colors.dart';
import 'package:flutter_application_prgrado/injection_container.dart';
import 'package:flutter_application_prgrado/presentation/session/bloc/session_bloc.dart';
import 'package:flutter_application_prgrado/presentation/session/bloc/session_event.dart';
import 'package:flutter_application_prgrado/presentation/pages/information_device/cubit/information_device_cubit.dart';
import 'package:flutter_application_prgrado/presentation/pages/information_device/widgets/cpu_widget.dart';
import 'package:flutter_application_prgrado/presentation/pages/information_device/widgets/memory_swap_widget.dart';
import 'package:flutter_application_prgrado/presentation/pages/information_device/widgets/memory_widget.dart';
import 'package:flutter_application_prgrado/presentation/pages/information_device/widgets/temp_widget.dart';
import 'package:flutter_application_prgrado/presentation/pages/information_device/widgets/storage_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class InformationDevicePage extends StatelessWidget {
  const InformationDevicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InformationDeviceCubit>(
      create: (context) => sl<InformationDeviceCubit>()..initial(),
      child: const InformationDeviceView(),
    );
  }
}

class InformationDeviceView extends StatelessWidget {
  const InformationDeviceView({super.key});

  @override
  Widget build(BuildContext context) {
    final sessionBloc = context.read<SessionBloc>();
    return MultiBlocListener(
      listeners: [
        BlocListener<InformationDeviceCubit, InformationDeviceState>(
          listenWhen: (previous, current) =>
              previous.statusConnection != current.statusConnection,
          listener: (context, state) {
            if (state.statusConnection == StatusConnection.disconnected) {
              sessionBloc.add(ConnectedSessionEvent(false));
            } else if (state.statusConnection == StatusConnection.connected) {
              sessionBloc.add(ConnectedSessionEvent(true));
            }
          },
        ),
      ],
      child: const InformationDeviceBody(),
    );
  }
}

class InformationDeviceBody extends StatelessWidget {
  const InformationDeviceBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<InformationDeviceCubit, InformationDeviceState>(
            buildWhen: ((previous, current) {
              return previous.statusConnection != current.statusConnection;
            }),
            builder: (context, state) {
              switch (state.statusConnection) {
                case StatusConnection.initial:
                  return Center(
                      child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Verificando conexión...",
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CircularProgressIndicator(
                        color: CustomColorPrimary().c,
                      ),
                    ],
                  ));
                case StatusConnection.disconnected:
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          'assets/lottie/animation_lny44lqi.json',
                          width: 150,
                          height: 150,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "¡Ups al parecer te desconectaste",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  );
                case StatusConnection.connected:
                  return BlocBuilder<InformationDeviceCubit,
                      InformationDeviceState>(
                    buildWhen: (previous, current) =>
                        previous.status != current.status,
                    builder: (context, state) {
                      final storageInfoEntity = state.storageInfoEntity;
                      final memoryInfoEntity = state.memoryInfoEntity;
                      final memoryInfoSwapEntity = state.memoryInfoSwapEntity;
                      final temperature = state.temperature;
                      final cpuUsage = state.cpuUsage;
                      return Column(
                        children: <Widget>[
                          Row(
                            children: [
                              Expanded(
                                child: StorageWidget(temp: storageInfoEntity),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: TemperatureWidget(temp: temperature),
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
                                child: MemoryWidget(info: memoryInfoEntity),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    CpuWidget(cpuUsage: cpuUsage),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    MemorySwapWidget(
                                        memoryInfoSwap: memoryInfoSwapEntity),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  );
              }
            },
          ),
        ],
      ),
    );
  }
}
