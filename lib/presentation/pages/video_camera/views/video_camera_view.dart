import 'package:flutter/material.dart';
import 'package:flutter_application_prgrado/presentation/pages/information_device/cubit/information_device_cubit.dart';
import 'package:flutter_application_prgrado/presentation/pages/video_camera/cubit/video_camera_cubit.dart';
import 'package:flutter_application_prgrado/presentation/pages/video_camera/views/video_camera_body.dart';
import 'package:flutter_application_prgrado/presentation/session/bloc/session_bloc.dart';
import 'package:flutter_application_prgrado/presentation/session/bloc/session_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VideoCameraView extends StatelessWidget {
  const VideoCameraView({super.key});

  @override
  Widget build(BuildContext context) {
    final sessionBloc = context.read<SessionBloc>();
    return BlocListener<VideoCameraCubit, VideoCameraState>(
      listenWhen: (previous, current) =>
          previous.statusConnection != current.statusConnection,
      listener: (context, state) {
        if (state.statusConnection == StatusConnection.disconnected) {
          sessionBloc.add(ConnectedSessionEvent(false));
        } else if (state.statusConnection == StatusConnection.connected) {
          sessionBloc.add(ConnectedSessionEvent(true));
        }
      },
      child: VideoCameraBody(),
    );
  }
}
