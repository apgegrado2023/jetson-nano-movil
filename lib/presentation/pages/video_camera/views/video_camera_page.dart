import 'package:flutter/material.dart';
import 'package:flutter_application_prgrado/injection_container.dart';
import 'package:flutter_application_prgrado/presentation/pages/video_camera/cubit/video_camera_cubit.dart';
import 'package:flutter_application_prgrado/presentation/pages/video_camera/views/video_camera_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VideoCameraPage extends StatelessWidget {
  const VideoCameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<VideoCameraCubit>()..initial(),
      child: VideoCameraView(),
    );
  }
}
