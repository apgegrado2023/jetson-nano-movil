import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_prgrado/config/routes/routes.dart';
import 'package:flutter_application_prgrado/core/app/cubit/notification_app_cubit.dart';
import 'package:flutter_application_prgrado/core/resources/data_state.dart';
import 'package:flutter_application_prgrado/data/data_sources/failures.dart';
import 'package:flutter_application_prgrado/data/models/error_dialog_data.dart';
import 'package:flutter_application_prgrado/data/models/good_dialog_data.dart';
import 'package:flutter_application_prgrado/data/models/warning_dialog_data.dart';
import 'package:flutter_application_prgrado/domain/entities/user.dart';
import 'package:flutter_application_prgrado/domain/usecases/change_password.dart';
import 'package:flutter_application_prgrado/domain/usecases/save_session.dart';
import 'package:flutter_application_prgrado/domain/usecases/update_filed_user.dart';
import 'package:flutter_application_prgrado/presentation/pages/information_device/notification.dart';
import 'package:flutter_application_prgrado/presentation/session/bloc/session_bloc.dart';
import 'package:flutter_application_prgrado/presentation/session/bloc/session_event.dart';
import 'package:flutter_application_prgrado/presentation/widgets/loading/loading.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final SessionBloc sessionBloc;
  final UpdateFileUserUseCase _updateFileUserUseCase;

  final SaveSessionUseCase _saveSessionUseCase;
  final ChangePasswordUseCase _changePasswordUseCase;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ProfileBloc(
    this.sessionBloc,
    this._updateFileUserUseCase,
    this._saveSessionUseCase,
    this._changePasswordUseCase,
  ) : super(ProfileState()) {
    on<StartedEvent>((event, emit) => _started(event, emit));
    on<NameChangedProfileEvent>(_onChangedName);

    on<LastNameChangedProfileEvent>(_onChangedLastName);
    on<PasswordChangedProfileEvent>(_onChangedPassword);

    on<UserNameChangedProfileEvent>(_onChangedUserName);
  }
  void _started(
    StartedEvent event,
    Emitter<ProfileState> emit,
  ) {
    final user = sessionBloc.state.user;
    emit(state.copyWith(userEntity: user));
  }

  Future<void> _onChangedName(
    NameChangedProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    final buildContext = event.context;
    await onChangeCustomer(emit, 'name', event.name, buildContext);
  }

  Future<void> onChangeCustomer(
    Emitter<ProfileState> emit,
    String title,
    String value,
    BuildContext buildContext,
  ) async {
    if (!isFormValid()) return;

    Loading.showText(buildContext, "Cambiando...");
    final httpResponse = await _updateFileUserUseCase.call(
        params: UpdateFileUserParams(
      sessionBloc.state.user!.id,
      title,
      value,
    ));
    Loading.close();

    await Future.delayed(Duration(microseconds: 500));

    if (httpResponse is DataSuccess) {
      final res = await saveSession(httpResponse.data!);
      if (res) {
        final user = sessionBloc.state.user;
        emit(state.copyWith(userEntity: user));
        Navigator.pop(buildContext);

        NotificationInteractor.onChangeNotification(
          NotificationSyn.okChangeData,
        );
      }
      return;
    } else if (httpResponse is DataFailed) {
      if (httpResponse.failure is NoInternetFailure) {
        NotificationInteractor.onChangeNotification(
          NotificationSyn.noConnection,
        );
      } else {
        NotificationInteractor.onChangeNotification(
          NotificationSyn.error,
        );
      }
    }
  }

  Future<bool> saveSession(UserEntity userEntity) async {
    sessionBloc.add(SaveSessionEvent(userEntity));
    final response = await _saveSessionUseCase.call(params: userEntity);
    if (response is DataSuccess) {
      return response.data!;
    } else {
      return false;
    }
  }

  Future<void> _onChangedPassword(
    PasswordChangedProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    final buildContext = event.context;
    if (!isFormValid()) return;

    Loading.showText(buildContext, "Cambiando...");
    final httpResponse = await _changePasswordUseCase.call(
        params: ChangePasswordParams(
      sessionBloc.state.user!.id,
      event.passwordNow,
      event.passwordLast,
    ));
    Loading.close();

    await Future.delayed(Duration(microseconds: 500));

    if (httpResponse is DataSuccess) {
      final user = sessionBloc.state.user;
      emit(state.copyWith(userEntity: user));

      Navigator.pop(buildContext);

      NotificationInteractor.onChangeNotification(
        NotificationSyn.okChangeData,
      );
    } else if (httpResponse is DataFailed) {
      if (httpResponse.failure is NoInternetFailure) {
        NotificationInteractor.onChangeNotification(
          NotificationSyn.noConnection,
        );
      } else if (httpResponse.failure is UnauthorizedFailure) {
        NotificationInteractor.onChangeNotification(
          NotificationSyn.errorPasswordNoExist,
        );
      } else {
        NotificationInteractor.onChangeNotification(
          NotificationSyn.error,
        );
      }
    }
  }

  Future<void> _onChangedLastName(
    LastNameChangedProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    final buildContext = event.context;
    await onChangeCustomer(emit, 'last_name', event.lastName, buildContext);
  }

  Future<void> _onChangedUserName(
    UserNameChangedProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    final buildContext = event.context;
    await onChangeCustomer(emit, 'user_name', event.userName, buildContext);
  }

  bool isFormValid() {
    final isEnableForm = formKey.currentState;
    return isEnableForm != null && formKey.currentState!.validate();
  }
}
