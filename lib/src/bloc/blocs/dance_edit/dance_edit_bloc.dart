import 'dart:async';

import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiver/core.dart';

class DanceEditBloc extends Bloc<DanceEditEvent, DanceEditState> {
  final DanceRepository danceRepository;
  final ModelMapper mapper;

  DanceEditBloc({
    required this.danceRepository,
    required this.mapper,
  }) : super(const DanceEditState()) {
    on<DanceEditStart>(_onDanceEditStart);
    on<DanceEditChangeName>(_onDanceEditChangeName);
    on<DanceEditSubmit>(_onDanceEditSubmit);
    on<DanceEditDelete>(_onDanceEditDelete);
  }

  FutureOr<void> _onDanceEditStart(
    DanceEditStart event,
    Emitter<DanceEditState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onDanceEditStart');

    try {
      emit(state.copyWith(
        status: DanceEditStatus.loading,
        ofId: Optional.fromNullable(event.danceId),
      ));

      DanceViewModel? danceViewModel;
      if (event.danceId != null) {
        DanceEntity danceEntity = await danceRepository.getById(event.danceId!);
        danceViewModel = mapper.toDanceViewModel(danceEntity);
      }

      emit(state.copyWith(
        status: DanceEditStatus.ready,
        ofId: Optional.fromNullable(event.danceId),
        initialDance: Optional.fromNullable(danceViewModel),
        error: const Optional.absent(),
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: DanceEditStatus.failure,
        ofId: Optional.fromNullable(event.danceId),
        error: Optional.of(error),
      ));
    }
  }

  FutureOr<void> _onDanceEditChangeName(
    DanceEditChangeName event,
    Emitter<DanceEditState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onDanceEditChangeName');

    emit(state.copyWith(
      danceName: Optional.of(event.danceName),
    ));
  }

  FutureOr<void> _onDanceEditSubmit(
    DanceEditSubmit event,
    Emitter<DanceEditState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onDanceEditSubmit');

    try {
      emit(state.copyWith(
        status: DanceEditStatus.loading,
      ));
      DanceViewModel danceViewModel;

      if (state.initialDance != null) {
        danceViewModel = state.initialDance!.copyWith(
          name: state.danceName,
        );
      } else {
        danceViewModel = DanceViewModel.createNew(
          name: state.danceName!,
        );
      }

      DanceEntity danceEntity =
          await danceRepository.save(mapper.toDanceEntity(danceViewModel));
      danceViewModel = mapper.toDanceViewModel(danceEntity);

      emit(DanceEditState(
        status: DanceEditStatus.editSuccess,
        ofId: danceViewModel.id,
        initialDance: danceViewModel,
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: DanceEditStatus.failure,
        error: Optional.of(error),
      ));
    }
  }

  FutureOr<void> _onDanceEditDelete(
    DanceEditDelete event,
    Emitter<DanceEditState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onDanceEditDelete');

    if (state.initialDance == null) return;
    try {
      emit(state.copyWith(
        status: DanceEditStatus.loading,
      ));

      await danceRepository.deleteById(state.initialDance!.id);

      emit(const DanceEditState(
        status: DanceEditStatus.deleteSuccess,
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: DanceEditStatus.failure,
        error: Optional.of(error),
      ));
    }
  }
}
