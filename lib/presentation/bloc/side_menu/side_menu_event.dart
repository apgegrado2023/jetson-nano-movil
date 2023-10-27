import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart'; // Añade esta importación para utilizar `BuildContext` si no la tienes.

abstract class SideMenuEvent extends Equatable {
  const SideMenuEvent();
}

class StartedSideMenuEvent extends SideMenuEvent {
  const StartedSideMenuEvent();

  @override
  List<Object?> get props => [];
}

class LogoutSideMenuEvent extends SideMenuEvent {
  final BuildContext context;

  const LogoutSideMenuEvent(this.context);

  @override
  List<Object?> get props => [context];
}
