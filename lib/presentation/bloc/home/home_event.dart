import 'package:flutter/cupertino.dart';

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

class CheckConnectionEvent implements HomeEvent {
  final BuildContext context;
  const CheckConnectionEvent(this.context);
}
