part of 'splash_bloc.dart';

enum ConnectionStateServer { connected, failed, disconected, loading }

class SplashState {
  final String? route;
  final ConnectionStateServer connectionStateServer;
  SplashState({
    this.route,
    this.connectionStateServer = ConnectionStateServer.disconected,
  });

  SplashState copyWith({
    String? route,
    ConnectionStateServer? connectionStateServer,
  }) {
    return SplashState(
      route: route ?? this.route,
      connectionStateServer:
          connectionStateServer ?? this.connectionStateServer,
    );
  }
}
