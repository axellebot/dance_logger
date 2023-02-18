import 'dart:async';

import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiver/core.dart';

class DanceDetailBloc extends Bloc<DanceDetailEvent, DanceDetailState> {
  final DanceRepository danceRepository;
  final ModelMapper mapper;

  DanceDetailBloc({
    required this.danceRepository,
    required this.mapper,
  }) : super(const DanceDetailState()) {
    on<DanceDetailLazyLoad>(_onDanceDetailLazyLoad);
    on<DanceDetailLoad>(_onDanceDetailLoad);
    on<DanceDetailRefresh>(_onDanceDetailRefresh);
    on<DanceDetailDelete>(_onDanceDelete);
  }

  FutureOr<void> _onDanceDetailLazyLoad(
    DanceDetailLazyLoad event,
    Emitter<DanceDetailState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onDanceDetailLazyLoad');

    emit(state.copyWith(
      status: DanceDetailStatus.loadingSuccess,
      ofDanceId: Optional.of(event.dance.id),
      dance: Optional.of(event.dance),
    ));
  }

  FutureOr<void> _onDanceDetailLoad(
    DanceDetailLoad event,
    Emitter<DanceDetailState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onDanceLoaded');

    try {
      emit(state.copyWith(
        status: DanceDetailStatus.loading,
        ofDanceId: Optional.of(event.danceId),
      ));

      DanceEntity danceDataModel = await danceRepository.getById(event.danceId);
      DanceViewModel danceViewModel = mapper.toDanceViewModel(danceDataModel);

      emit(state.copyWith(
        status: DanceDetailStatus.loadingSuccess,
        ofDanceId: Optional.of(danceViewModel.id),
        dance: Optional.of(danceViewModel),
        error: const Optional.absent(),
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: DanceDetailStatus.loadingFailure,
        ofDanceId: Optional.of(event.danceId),
        error: Optional.of(error),
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

      DanceEntity danceDataModel = await danceRepository.getById(state.ofDanceId!);
      DanceViewModel danceViewModel = mapper.toDanceViewModel(danceDataModel);

      emit(state.copyWith(
        status: DanceDetailStatus.refreshingSuccess,
        ofDanceId: Optional.of(danceViewModel.id),
        dance: Optional.of(danceViewModel),
        error: const Optional.absent(),
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: DanceDetailStatus.refreshingFailure,
        error: Optional.of(error),
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
      await danceRepository.deleteById(state.dance!.id);

      emit(const DanceDetailState(
        status: DanceDetailStatus.deleteSuccess,
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: DanceDetailStatus.deleteFailure,
        error: Optional.of(error),
      ));
    }
  }
}
