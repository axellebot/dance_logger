import 'dart:async';

import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DanceDetailBloc extends Bloc<DanceDetailEvent, DanceDetailState> {
  final DanceRepository danceRepository;
  final ModelMapper mapper;

  DanceDetailBloc({
    required this.danceRepository,
    required this.mapper,
  }) : super(const DanceDetailState()) {
    on<DanceDetailLoad>(_onDanceLoad);
    on<DanceDetailRefresh>(_onDanceDetailRefresh);
    on<DanceDetailDelete>(_onDanceDelete);
  }

  FutureOr<void> _onDanceLoad(
    DanceDetailLoad event,
    Emitter<DanceDetailState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onDanceLoaded');

    try {
      emit(state.copyWith(
        status: DanceDetailStatus.loading,
      ));

      DanceEntity danceDataModel = await danceRepository.getById(event.danceId);
      DanceViewModel danceViewModel = mapper.toDanceViewModel(danceDataModel);

      emit(state.copyWith(
        status: DanceDetailStatus.detailSuccess,
        ofId: danceViewModel.id,
        dance: danceViewModel,
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: DanceDetailStatus.failure,
        ofId: event.danceId,
        error: error,
      ));
    }
  }

  FutureOr<void> _onDanceDetailRefresh(
    DanceDetailRefresh event,
    Emitter<DanceDetailState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onDanceDetailRefresh');

    try {
      emit(state.copyWith(
        status: DanceDetailStatus.refreshing,
      ));

      DanceEntity danceDataModel = await danceRepository.getById(state.ofId!);
      DanceViewModel danceViewModel = mapper.toDanceViewModel(danceDataModel);

      emit(state.copyWith(
        status: DanceDetailStatus.detailSuccess,
        ofId: danceViewModel.id,
        dance: danceViewModel,
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: DanceDetailStatus.failure,
        error: error,
      ));
    }
  }

  FutureOr<void> _onDanceDelete(
    DanceDetailDelete event,
    Emitter<DanceDetailState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onDanceDeleted');

    if (state.dance == null) return;
    try {
      emit(state.copyWith(
        status: DanceDetailStatus.loading,
      ));

      await danceRepository.deleteById(state.dance!.id);

      emit(const DanceDetailState(
        status: DanceDetailStatus.deleteSuccess,
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: DanceDetailStatus.failure,
        error: error,
      ));
    }
  }
}
