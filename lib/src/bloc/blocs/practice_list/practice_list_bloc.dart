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
    on<PracticeListSelect>(_onPracticeListSelect);
    on<PracticeListUnselect>(_onPracticeListUnselect);
    on<PracticeListDelete>(_onPracticeListDelete);
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
        status: PracticeListStatus.refreshing,
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

  FutureOr<void> _onPracticeListSelect(
    PracticeListSelect event,
    Emitter<PracticeListState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onPracticeListSelect');

    emit(state.copyWith(
      selectedPractices: List.of(state.selectedPractices)
        ..add(event.practiceId),
    ));
  }

  FutureOr<void> _onPracticeListUnselect(
    PracticeListUnselect event,
    Emitter<PracticeListState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onPracticeListUnselect');

    emit((event.practiceId != null)
        ? state.copyWith(
            selectedPractices: List.of(state.selectedPractices)
              ..remove(event.practiceId),
          )
        : state.copyWith(
            selectedPractices: [],
          ));
  }

  FutureOr<void> _onPracticeListDelete(
    PracticeListDelete event,
    Emitter<PracticeListState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onPracticeListSelect');
    if (state.selectedPractices.isEmpty) return;

    try {
      for (String practiceId in state.selectedPractices) {
        await practiceRepository.deleteById(practiceId);
        emit(state.copyWith(
          practices: List.of(state.practices)
            ..removeWhere((element) => element.id == practiceId),
          selectedPractices: List.of(state.selectedPractices)
            ..remove(practiceId),
        ));
      }
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
