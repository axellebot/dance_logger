import 'dart:async';

import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiver/core.dart';

class MomentEditBloc extends Bloc<MomentEditEvent, MomentEditState> {
  final MomentRepository momentRepository;
  final ModelMapper mapper;

  MomentEditBloc({
    required this.momentRepository,
    required this.mapper,
  }) : super(const MomentEditState()) {
    on<MomentEditStart>(_onMomentEditStart);
    on<MomentEditChangeStartTime>(_onMomentEditChangeStartTime);
    on<MomentEditChangeEndTime>(_onMomentEditChangeEndTime);
    on<MomentEditChangeFigure>(_onMomentEditChangeFigure);
    on<MomentEditChangeVideo>(_onMomentEditChangeVideo);
    on<MomentEditChangeArtists>(_onMomentEditChangeArtists);
    on<MomentEditSubmit>(_onMomentEditSubmit);
    on<MomentEditDelete>(_onMomentEditDelete);
  }

  FutureOr<void> _onMomentEditStart(
    MomentEditStart event,
    Emitter<MomentEditState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onMomentEditStart');
    try {
      emit(state.copyWith(
        status: MomentEditStatus.loading,
        ofId: Optional.fromNullable(event.momentId),
      ));

      MomentViewModel? momentViewModel;
      if (event.momentId != null) {
        MomentEntity momentEntity =
            await momentRepository.getById(event.momentId!);
        momentViewModel = mapper.toMomentViewModel(momentEntity);
      }

      emit(state.copyWith(
        status: MomentEditStatus.ready,
        ofId: Optional.fromNullable(event.momentId),
        initialMoment: Optional.fromNullable(momentViewModel),
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: MomentEditStatus.failure,
        ofId: Optional.fromNullable(event.momentId),
        error: Optional.of(error),
      ));
    }
  }

  FutureOr<void> _onMomentEditChangeStartTime(
    MomentEditChangeStartTime event,
    Emitter<MomentEditState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onMomentEditChangeEndTime');
    emit(state.copyWith(
      startTime: Optional.of(event.startTime),
    ));
  }

  FutureOr<void> _onMomentEditChangeEndTime(
    MomentEditChangeEndTime event,
    Emitter<MomentEditState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onMomentEditChangeEndTime');
    emit(state.copyWith(
      endTime: Optional.fromNullable(event.endTime),
    ));
  }

  FutureOr<void> _onMomentEditChangeFigure(
    MomentEditChangeFigure event,
    Emitter<MomentEditState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onMomentEditChangeFigure');
    emit(state.copyWith(
      figure: Optional.of(event.figure),
    ));
  }

  FutureOr<void> _onMomentEditChangeVideo(
    MomentEditChangeVideo event,
    Emitter<MomentEditState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onMomentEditChangeVideo');
    emit(state.copyWith(
      video: Optional.of(event.video),
    ));
  }

  FutureOr<void> _onMomentEditChangeArtists(
    MomentEditChangeArtists event,
    Emitter<MomentEditState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onMomentEditChangeArtist');
    emit(state.copyWith(
      artists: event.artists,
    ));
  }

  FutureOr<void> _onMomentEditSubmit(
    MomentEditSubmit event,
    Emitter<MomentEditState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onMomentEditSubmit');

    try {
      emit(state.copyWith(
        status: MomentEditStatus.loading,
      ));
      MomentViewModel momentViewModel;

      if (state.initialMoment != null) {
        momentViewModel = state.initialMoment!.copyWith(
            startTime: state.startTime,
            endTime: Optional.fromNullable(state.endTime));
        momentViewModel.incrementVersion();
      } else {
        momentViewModel = MomentViewModel.createNew(
          startTime: state.startTime!,
          endTime: state.endTime,
          figureId: state.figure!.id,
          videoId: state.video!.id,
        );
      }

      MomentEntity momentEntity =
          await momentRepository.save(mapper.toMomentEntity(momentViewModel));
      momentViewModel = mapper.toMomentViewModel(momentEntity);

      emit(state.copyWith(
        status: MomentEditStatus.editSuccess,
        ofId: Optional.of(momentViewModel.id),
        initialMoment: Optional.of(momentViewModel),
        error: const Optional.absent(),
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: MomentEditStatus.failure,
        error: Optional.of(error),
      ));
    }
  }

  FutureOr<void> _onMomentEditDelete(
    MomentEditDelete event,
    Emitter<MomentEditState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onMomentEditDelete');

    if (state.initialMoment == null) return;
    try {
      emit(state.copyWith(
        status: MomentEditStatus.loading,
      ));

      await momentRepository.deleteById(state.initialMoment!.id);

      emit(const MomentEditState(
        status: MomentEditStatus.deleteSuccess,
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: MomentEditStatus.failure,
        error: Optional.of(error),
      ));
    }
  }
}
