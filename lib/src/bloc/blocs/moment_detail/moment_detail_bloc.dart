import 'dart:async';

import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiver/core.dart';

class MomentDetailBloc extends Bloc<MomentDetailEvent, MomentDetailState> {
  final MomentRepository momentRepository;
  final ModelMapper mapper;

  MomentDetailBloc({
    required this.momentRepository,
    required this.mapper,
  }) : super(const MomentDetailState()) {
    on<MomentDetailLazyLoad>(_onMomentDetailLazyLoad);
    on<MomentDetailLoad>(_onMomentDetailLoad);
    on<MomentDetailRefresh>(_onMomentDetailRefresh);
    on<MomentDetailDelete>(_onMomentDelete);
  }

  FutureOr<void> _onMomentDetailLazyLoad(
    MomentDetailLazyLoad event,
    Emitter<MomentDetailState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onMomentDetailLazyLoad');

    emit(state.copyWith(
      status: MomentDetailStatus.loadingSuccess,
      ofMomentId: Optional.of(event.moment.id),
      moment: Optional.of(event.moment),
    ));
  }

  FutureOr<void> _onMomentDetailLoad(
    MomentDetailLoad event,
    Emitter<MomentDetailState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onMomentDetailLoad');

    try {
      emit(state.copyWith(
        status: MomentDetailStatus.loading,
        ofMomentId: Optional.of(event.momentId),
      ));

      MomentEntity momentDataModel = await momentRepository.getById(event.momentId);
      MomentViewModel momentViewModel = mapper.toMomentViewModel(momentDataModel);

      emit(state.copyWith(
        status: MomentDetailStatus.loadingSuccess,
        ofMomentId: Optional.of(momentViewModel.id),
        moment: Optional.of(momentViewModel),
        error: const Optional.absent(),
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: MomentDetailStatus.loadingFailure,
        ofMomentId: Optional.of(event.momentId),
        error: Optional.of(error),
      ));
    }
  }

  FutureOr<void> _onMomentDetailRefresh(
    MomentDetailRefresh event,
    Emitter<MomentDetailState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onMomentDetailRefresh');

    try {
      emit(state.copyWith(
        status: MomentDetailStatus.refreshing,
      ));

      MomentEntity momentDataModel = await momentRepository.getById(state.ofMomentId!);
      MomentViewModel momentViewModel = mapper.toMomentViewModel(momentDataModel);

      emit(state.copyWith(
        status: MomentDetailStatus.refreshingSuccess,
        ofMomentId: Optional.of(momentViewModel.id),
        moment: Optional.of(momentViewModel),
        error: const Optional.absent(),
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: MomentDetailStatus.refreshingFailure,
        error: Optional.fromNullable(error),
      ));
    }
  }

  FutureOr<void> _onMomentDelete(
    MomentDetailDelete event,
    Emitter<MomentDetailState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onMomentDelete');

    if (state.moment == null) return;
    try {
      await momentRepository.deleteById(state.moment!.id);

      emit(const MomentDetailState(
        status: MomentDetailStatus.deleteSuccess,
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: MomentDetailStatus.deleteFailure,
        error: Optional.of(error),
      ));
    }
  }
}
