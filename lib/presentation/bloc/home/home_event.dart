import 'package:flutter/material.dart';

abstract class HomeEvent {
  const HomeEvent();
}

class IndexChangedHomeEvent implements HomeEvent {
  final int index;
  const IndexChangedHomeEvent(this.index);
}

class InitHomeEvent implements HomeEvent {
  const InitHomeEvent();
}
