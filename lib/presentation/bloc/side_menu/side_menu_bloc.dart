import 'package:flutter/cupertino.dart';
import 'package:flutter_application_prgrado/presentation/bloc/session/bloc/session_bloc.dart';
import 'package:flutter_application_prgrado/presentation/bloc/side_menu/side_menu_event.dart';
import 'package:flutter_application_prgrado/presentation/bloc/side_menu/side_menu_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SideMenuBloc extends Bloc<SideMenuEvent, SideMenuState> {
  final SessionBloc sessionBloc;
  //final authenticationRepository = Get.find<AuthenticationRepository>();
  SideMenuBloc(this.sessionBloc) : super(SideMenuState()) {
    on<StartedSideMenuEvent>((event, emit) => _started);
    on<LogoutSideMenuEvent>((event, emit) => _logout);
  }

  void _started(
    StartedSideMenuEvent event,
    Emitter<SideMenuState> emit,
  ) {
    //emit(state.copyWith(email: email));
  }

  Future<void> _logout(
    LogoutSideMenuEvent event,
    Emitter<SideMenuState> emit,
  ) async {
    /*final BuildContext buildContext = event.context;
    await authenticationRepository.signOut();
    sessionBloc.removerUser();

    Future.microtask(() {
      Navigator.pushReplacementNamed(buildContext, Routes.LOGIN);
    });*/
  }
}
