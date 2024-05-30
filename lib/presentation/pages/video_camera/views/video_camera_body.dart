import 'package:flutter/material.dart';
import 'package:flutter_application_prgrado/presentation/pages/video_camera/cubit/video_camera_cubit.dart';
import 'package:flutter_application_prgrado/presentation/pages/video_camera/widgets/camera_one.dart';
import 'package:flutter_application_prgrado/presentation/pages/video_camera/widgets/camera_two.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VideoCameraBody extends StatelessWidget {
  VideoCameraBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoCameraCubit, VideoCameraState>(
      builder: (context, state) {
        final uriCameraOne = state.cameraOne!;
        final uriCameraTwo = state.cameraTwo!;
        return Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                CameraOne(uri: uriCameraOne),
                SizedBox(height: 10),
                CameraTwo(uri: uriCameraTwo),
              ],
            ),
          ),
        );
      },
    );
  }
}
