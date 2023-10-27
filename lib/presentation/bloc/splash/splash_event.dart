part of 'splash_bloc.dart';

abstract class SplashEvent {}

class ChangeRoute extends SplashEvent {
  final String route;
  ChangeRoute(this.route);
}

class InitialEvent extends SplashEvent {}
