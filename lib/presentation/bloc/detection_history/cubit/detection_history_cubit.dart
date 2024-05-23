import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../domain/entities/detection_history.dart';
import '../../../../domain/usecases/check_connection.dart';
import '../../../../domain/usecases/get_detection_history.dart';
import '../../session/bloc/session_bloc.dart';
import '../../session/bloc/session_event.dart';

part 'detection_history_state.dart';

class DetectionHistoryCubit extends Cubit<DetectionHistoryState> {
  DetectionHistoryCubit(this._detectionHistoryUseCase,
      this._checkConnectionUseCase, this.sessionBloc)
      : super(DetectionHistoryInitial());
  final GetDetectionHistoryUseCase _detectionHistoryUseCase;
  final CheckConnectionUseCase _checkConnectionUseCase;
  final SessionBloc sessionBloc;
  bool _timerStarted = false;
  init() async {
    await loadData();
    verificationConnection();
  }

  Future<void> loadData() async {
    final listMembers = await loadDataMembers();

    emit(
      DetectionHistoryDone(
          listMemberEntity: listMembers,
          listMemberEntityOriginal: listMembers,
          index: 0),
    );
  }

  Future<List<DetectionHistoryEntity>?> loadDataMembers() async {
    final httpResponse = await _detectionHistoryUseCase();
    if (httpResponse is DataSuccess) {
      return httpResponse.data;
    } else {
      return null;
    }
  }

  Future<void> loadDataReload() async {
    final listMembers = await loadDataMembers();
    emit(
      state.copyWithList(
          listMemberEntity: listMembers,
          listMemberEntityOriginal: listMembers,
          index: 0),
    );
  }

  Future<void> verificationConnection() async {
    print('metodo verification iniciado');
    _timerStarted = true;
    while (_timerStarted) {
      final httpResponse = await _checkConnectionUseCase(true);
      if (httpResponse is DataSuccess) {
        sessionBloc.add(ConnectedSessionEvent(true));
        print('conectado');
        if (state is DetectionHistoryDisconnection) {
          print('actualizando lista');
          await loadDataMembers();
        }
      } else {
        sessionBloc.add(ConnectedSessionEvent(false));
        onDisconnection();
      }
      await Future.delayed(Duration(seconds: 8));
    }
  }

  void onDisconnection() {
    emit(DetectionHistoryDisconnection());
  }

  searchMember(String character) {
    if (state is! DetectionHistoryDone) return;

    if (state.index == 0) {
      var filteredMembers = state.listMemberEntityOriginal!
          .where((member) => member.description!
              .toLowerCase()
              .contains(character.toLowerCase()))
          .toList();

      emit(state.copyWithList(listMemberEntity: filteredMembers));
      return;
    }
    var filteredMembers = state.listMemberEntityOriginal!
        .where((member) =>
            member.description!
                .toLowerCase()
                .contains(character.toLowerCase()) &&
            member.typeDetection == state.index)
        .toList();

    emit(state.copyWithList(listMemberEntity: filteredMembers));
  }

  void onIndexChanged(int index) {
    if (index == 0) {
      var filteredMembers = state.listMemberEntityOriginal!
          .where((member) => member.description!.toLowerCase().contains(''))
          .toList();

      emit(state.copyWithList(listMemberEntity: filteredMembers, index: index));
      return;
    }

    var filteredMembers = state.listMemberEntityOriginal!
        .where((member) => member.typeDetection! == index)
        .toList();
    emit(state.copyWithList(listMemberEntity: filteredMembers, index: index));
  }

  @override
  Future<void> close() {
    print("se cierra");
    _timerStarted = false;
    return super.close();
  }
}
