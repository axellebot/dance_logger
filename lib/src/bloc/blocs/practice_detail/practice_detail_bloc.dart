import 'dart:async';

import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiver/core.dart';

class PracticeDetailBloc
    extends Bloc<PracticeDetailEvent, PracticeDetailState> {
  final PracticeRepository practiceRepository;
  final ModelMapper mapper;

  PracticeDetailBloc({
    required this.practiceRepository,
    required this.mapper,
  }) : super(const PracticeDetailState()) {
    on<PracticeDetailLoad>(_onPracticeDetailLoad);
    on<PracticeDetailRefresh>(_onPracticeDetailRefresh);
    on<PracticeDetailDelete>(_onPracticeDelete);
  }

  FutureOr<void> _onPracticeDetailLoad(
    PracticeDetailLoad event,
    Emitter<PracticeDetailState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onPracticeDetailLoad');

    try {
      emit(state.copyWith(
        status: PracticeDetailStatus.refreshing,
        ofId: Optional.of(event.practiceId),
      ));

      PracticeEntity practiceDataModel =
          await practiceRepository.getById(event.practiceId);
      PracticeViewModel practiceViewModel =
          mapper.toPracticeViewModel(practiceDataModel);

      emit(state.copyWith(
        status: PracticeDetailStatus.refreshingSuccess,
        ofId: Optional.of(practiceViewModel.id),
        practice: Optional.of(practiceViewModel),
        error: const Optional.absent(),
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: PracticeDetailStatus.refreshingFailure,
        ofId: Optional.of(event.practiceId),
        error: Optional.of(error),
      ));
    }
  }

  FutureOr<void> _onPracticeDetailRefresh(
    PracticeDetailRefresh event,
    Emitter<PracticeDetailState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onPracticeDetailRefresh');

    try {
      emit(state.copyWith(
        status: PracticeDetailStatus.refreshing,
      ));

      PracticeEntity practiceDataModel =
          await practiceRepository.getById(state.ofId!);
      PracticeViewModel practiceViewModel =
          mapper.toPracticeViewModel(practiceDataModel);

      emit(state.copyWith(
        status: PracticeDetailStatus.refreshingSuccess,
        ofId: Optional.of(practiceViewModel.id),
        practice: Optional.of(practiceViewModel),
        error: const Optional.absent(),
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: PracticeDetailStatus.refreshingFailure,
        error: Optional.fromNullable(error),
      ));
    }
  }

  FutureOr<void> _onPracticeDelete(
    PracticeDetailDelete event,
    Emitter<PracticeDetailState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onPracticeDeleted');

    if (state.practice == null) return;
    try {
      await practiceRepository.deleteById(state.practice!.id);

      emit(const PracticeDetailState(
        status: PracticeDetailStatus.deleteSuccess,
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: PracticeDetailStatus.deleteFailure,
        error: Optional.of(error),
      ));
    }
  }
}
