import 'dart:async';

import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MomentListBloc extends Bloc<MomentListEvent, MomentListState> {
  final MomentRepository momentRepository;
  final ModelMapper mapper;

  MomentListBloc({
    required this.momentRepository,
    required this.mapper,
  }) : super(const MomentListState()) {
    on<MomentListLoad>(_onMomentListLoad);
    on<MomentListLoadMore>(_onMomentListLoadMore);
    on<MomentListRefresh>(_onMomentListRefresh);
  }

  FutureOr<void> _onMomentListLoad(
    MomentListLoad event,
    Emitter<MomentListState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onMomentListLoad');
    try {
      emit(state.copyWith(
        status: MomentListStatus.loading,
      ));

      final List<MomentViewModel> momentViewModels;
      momentViewModels = await _fetchMoments(
        ofArtist: event.ofArtist,
        ofFigure: event.ofFigure,
        ofVideo: event.ofVideo,
        offset: 0,
      );
      emit(MomentListState(
        status: MomentListStatus.success,
        ofArtist: event.ofArtist,
        ofFigure: event.ofFigure,
        ofVideo: event.ofVideo,
        moments: momentViewModels,
        hasReachedMax: false,
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: MomentListStatus.failure,
        error: error,
      ));
    }
  }

  FutureOr<void> _onMomentListLoadMore(
    MomentListLoadMore event,
    Emitter<MomentListState> emit,
  ) async {
    if (state.status != MomentListStatus.success) return;
    try {
      final List<MomentViewModel> momentViewModels;
      momentViewModels = await _fetchMoments(
        ofArtist: state.ofArtist,
        ofFigure: state.ofFigure,
        ofVideo: state.ofVideo,
        offset: state.moments.length,
      );
      if (momentViewModels.isNotEmpty) {
        emit(state.copyWith(
          moments: List.of(state.moments)..addAll(momentViewModels),
          hasReachedMax: false,
        ));
      } else {
        emit(state.copyWith(
          hasReachedMax: true,
        ));
      }
    } on Error catch (error) {
      emit(state.copyWith(
        status: MomentListStatus.failure,
        error: error,
      ));
    }
  }

  FutureOr<void> _onMomentListRefresh(
    MomentListRefresh event,
    Emitter<MomentListState> emit,
  ) async {
    try {
      emit(state.copyWith(
        status: MomentListStatus.loading,
      ));

      List<MomentViewModel> momentViewModels = await _fetchMoments(
        ofArtist: state.ofArtist,
        ofFigure: state.ofFigure,
        ofVideo: state.ofVideo,
        offset: 0,
      );

      emit(state.copyWith(
        status: MomentListStatus.success,
        moments: momentViewModels,
        hasReachedMax: false,
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: MomentListStatus.failure,
        error: error,
      ));
    }
  }

  Future<List<MomentViewModel>> _fetchMoments({
    String? ofArtist,
    String? ofFigure,
    String? ofVideo,
    required int offset,
    int limit = 10,
  }) async {
    List<MomentEntity> momentEntities;

    if (ofArtist != null) {
      momentEntities = await momentRepository.getMomentsOfArtist(
        ofArtist,
        offset: Offset(
          offset: offset,
          limit: limit,
        ),
      );
    } else if (ofFigure != null) {
      momentEntities = await momentRepository.getMomentsOfFigure(
        ofFigure,
        offset: Offset(
          offset: offset,
          limit: limit,
        ),
      );
    } else if (ofVideo != null) {
      momentEntities = await momentRepository.getMomentsOfVideo(
        ofVideo,
        offset: Offset(
          offset: offset,
          limit: limit,
        ),
      );
    } else {
      momentEntities = await momentRepository.getList(
        offset: Offset(
          offset: offset,
          limit: limit,
        ),
      );
    }

    List<MomentViewModel> momentViewModels = momentEntities
        .map<MomentViewModel>(
            (timeEntity) => mapper.toMomentViewModel(timeEntity))
        .toList();
    return momentViewModels;
  }
}
