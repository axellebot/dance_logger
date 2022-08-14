import 'dart:async';

import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PracticeListBloc extends Bloc<PracticeListEvent, PracticeListState> {
  final PracticeRepository practiceRepository;
  final ModelMapper mapper;

  PracticeListBloc({
    required this.practiceRepository,
    required this.mapper,
  }) : super(const PracticeListState()) {
    on<PracticeListLoad>(_onPracticeListLoad);
    on<PracticeListLoadMore>(_onPracticeListLoadMore);
    on<PracticeListRefresh>(_onPracticeListRefresh);
  }

  FutureOr<void> _onPracticeListLoad(
    PracticeListLoad event,
    Emitter<PracticeListState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onPracticeListLoad');
    try {
      emit(state.copyWith(
        status: PracticeListStatus.loading,
      ));

      final List<PracticeViewModel> practiceViewModels;
      practiceViewModels = await _fetchPractices(
        ofDance: event.ofDance,
        ofFigure: event.ofFigure,
        ofVideo: event.ofVideo,
        offset: 0,
      );
      emit(state.copyWith(
        status: PracticeListStatus.success,
        ofDance: event.ofDance,
        ofFigure: event.ofFigure,
        ofVideo: event.ofVideo,
        practices: practiceViewModels,
        hasReachedMax: false,
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: PracticeListStatus.failure,
        error: error,
      ));
    }
  }

  FutureOr<void> _onPracticeListLoadMore(
    PracticeListLoadMore event,
    Emitter<PracticeListState> emit,
  ) async {
    if (state.status != PracticeListStatus.success) return;
    try {
      final List<PracticeViewModel> practiceViewModels;

      practiceViewModels = await _fetchPractices(
        ofArtist: state.ofArtist,
        ofDance: state.ofDance,
        ofFigure: state.ofFigure,
        ofVideo: state.ofVideo,
        offset: state.practices.length,
      );
      if (practiceViewModels.isNotEmpty) {
        emit(state.copyWith(
          practices: List.of(state.practices)..addAll(practiceViewModels),
          hasReachedMax: false,
        ));
      } else {
        emit(state.copyWith(
          hasReachedMax: true,
        ));
      }
    } on Error catch (error) {
      emit(state.copyWith(
        status: PracticeListStatus.failure,
        error: error,
      ));
    }
  }

  FutureOr<void> _onPracticeListRefresh(
    PracticeListRefresh event,
    Emitter<PracticeListState> emit,
  ) async {
    try {
      emit(state.copyWith(
        status: PracticeListStatus.loading,
      ));

      List<PracticeViewModel> practiceViewModels = await _fetchPractices(
        ofArtist: state.ofArtist,
        ofDance: state.ofDance,
        ofFigure: state.ofFigure,
        ofVideo: state.ofVideo,
        offset: 0,
      );

      emit(state.copyWith(
        status: PracticeListStatus.success,
        practices: practiceViewModels,
        hasReachedMax: false,
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: PracticeListStatus.failure,
        error: error,
      ));
    }
  }

  Future<List<PracticeViewModel>> _fetchPractices({
    String? ofArtist,
    String? ofDance,
    String? ofFigure,
    String? ofVideo,
    required int offset,
    int limit = 10,
  }) async {
    List<PracticeEntity> practiceEntities;

    if (ofFigure != null) {
      practiceEntities = await practiceRepository.getPracticesOfFigure(
        ofFigure,
        offset: Offset(
          offset: offset,
          limit: limit,
        ),
      );
    } else {
      practiceEntities = await practiceRepository.getList(
        offset: Offset(
          offset: offset,
          limit: limit,
        ),
      );
    }

    List<PracticeViewModel> practiceViewModels = practiceEntities
        .map<PracticeViewModel>(
            (practiceEntity) => mapper.toPracticeViewModel(practiceEntity))
        .toList();
    return practiceViewModels;
  }
}
