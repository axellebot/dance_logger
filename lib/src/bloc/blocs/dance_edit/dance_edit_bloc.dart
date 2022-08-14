import 'dart:async';

import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      ));

      DanceViewModel? danceViewModel;
      if (event.danceId != null) {
        DanceEntity danceEntity = await danceRepository.getById(event.danceId!);
        danceViewModel = mapper.toDanceViewModel(danceEntity);
      }

      emit(state.copyWith(
        status: DanceEditStatus.ready,
        initialDance: danceViewModel,
      ));
    } on Error catch (error) {
      emit(DanceEditState(
        status: DanceEditStatus.failure,
        error: error,
      ));
    }
  }

  FutureOr<void> _onDanceEditChangeName(
    DanceEditChangeName event,
    Emitter<DanceEditState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onDanceEditChangeName');
    emit(state.copyWith(danceName: event.danceName!));
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
        danceViewModel = state.initialDance!;
        danceViewModel.change(
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
        initialDance: danceViewModel,
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: DanceEditStatus.failure,
        error: error,
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
        error: error,
      ));
    }
  }
}
