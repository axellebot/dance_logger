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
        status: PracticeListStatus.loadingSuccess,
        ofDance: event.ofDance,
        ofFigure: event.ofFigure,
        ofVideo: event.ofVideo,
        practices: practiceViewModels,
        hasReachedMax: false,
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: PracticeListStatus.loadingFailure,
        error: error,
      ));
    }
  }

  FutureOr<void> _onPracticeListLoadMore(
    PracticeListLoadMore event,
    Emitter<PracticeListState> emit,
  ) async {
    try {
      emit(state.copyWith(
        status: PracticeListStatus.loading,
      ));

      final List<PracticeViewModel> practiceViewModels;
      practiceViewModels = await _fetchPractices(
        ofArtist: state.ofArtist,
        ofDance: state.ofDance,
        ofFigure: state.ofFigure,
        ofVideo: state.ofVideo,
        offset: state.practices.length,
      );

      emit(state.copyWith(
        status: PracticeListStatus.loadingSuccess,
        practices: List.of(state.practices)..addAll(practiceViewModels),
        hasReachedMax: practiceViewModels.isEmpty,
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: PracticeListStatus.loadingFailure,
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
        status: PracticeListStatus.refreshingSuccess,
        practices: practiceViewModels,
        hasReachedMax: false,
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: PracticeListStatus.refreshingFailure,
        error: error,
      ));
    }
  }

  FutureOr<void> _onPracticeListSelect(
    PracticeListSelect event,
    Emitter<PracticeListState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onPracticeListSelect');

    final newSelectedPractices = List.of(state.selectedPractices);
    for (PracticeViewModel practice in event.practices) {
      newSelectedPractices.removeWhere((element) => element.id == practice.id!);
    }
    newSelectedPractices.addAll(event.practices);

    emit(state.copyWith(
      selectedPractices: newSelectedPractices,
    ));
  }

  FutureOr<void> _onPracticeListUnselect(
    PracticeListUnselect event,
    Emitter<PracticeListState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onPracticeListUnselect');

    if (event.practices == null) {
      return emit(state.copyWith(
        selectedPractices: [],
      ));
    }

    final newSelectedPractices = List.of(state.selectedPractices);
    for (PracticeViewModel practice in event.practices!) {
      newSelectedPractices.removeWhere((element) => element.id == practice.id!);
    }

    emit(state.copyWith(
      selectedPractices: newSelectedPractices,
    ));
  }

  FutureOr<void> _onPracticeListDelete(
    PracticeListDelete event,
    Emitter<PracticeListState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onPracticeListSelect');

    if (state.selectedPractices.isEmpty) return;

    try {
      for (PracticeViewModel practice in state.selectedPractices) {
        await practiceRepository.deleteById(practice.id);
        emit(state.copyWith(
          status: PracticeListStatus.deleteSuccess,
          practices: List.of(state.practices)
            ..removeWhere((element) => element.id == practice.id),
          selectedPractices: List.of(state.selectedPractices)
            ..removeWhere((element) => element.id == practice.id),
        ));
      }
    } on Error catch (error) {
      emit(state.copyWith(
        status: PracticeListStatus.deleteFailure,
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
