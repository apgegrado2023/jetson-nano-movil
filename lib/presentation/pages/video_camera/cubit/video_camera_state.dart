part of 'video_camera_cubit.dart';

class VideoCameraState extends Equatable {
  const VideoCameraState({
    this.cameraOne,
    this.cameraTwo,
    this.statusConnection,
  });

  final Uri? cameraOne;
  final Uri? cameraTwo;
  final StatusConnection? statusConnection;

  // Método copyWith
  VideoCameraState copyWith({
    Uri? cameraOne,
    Uri? cameraTwo,
    StatusConnection? statusConnection,
  }) {
    return VideoCameraState(
      cameraOne: cameraOne ?? this.cameraOne,
      cameraTwo: cameraTwo ?? this.cameraTwo,
      statusConnection: statusConnection ?? this.statusConnection,
    );
  }

  @override
  List<Object?> get props => [
        cameraOne,
        statusConnection,
        cameraTwo,
      ];
}
