import 'dart:async';

import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiver/core.dart';

class DanceListBloc extends Bloc<DanceListEvent, DanceListState> {
  final DanceRepository danceRepository;
  final ModelMapper mapper;

  DanceListBloc({
    required this.danceRepository,
    required this.mapper,
  }) : super(const DanceListState()) {
    on<DanceListLoad>(_onDanceListLoad);
    on<DanceListLoadMore>(_onDanceListLoadMore);
    on<DanceListRefresh>(_onDanceListRefresh);
    on<DanceListSelect>(_onDanceListSelect);
    on<DanceListUnselect>(_onDanceListUnselect);
    on<DanceListDelete>(_onDanceListDelete);
  }

  FutureOr<void> _onDanceListLoad(
    DanceListLoad event,
    Emitter<DanceListState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onDanceListLoad');

    try {
      emit(state.copyWith(
        status: DanceListStatus.loading,
        error: const Optional.absent(),
      ));

      final List<DanceViewModel> danceViewModels;
      danceViewModels = await _fetchDances(
        ofSearch: event.ofSearch,
        ofArtist: event.ofArtist,
        ofVideo: event.ofVideo,
        offset: 0,
      );

      emit(state.copyWith(
        status: DanceListStatus.loadingSuccess,
        ofSearch: Optional.fromNullable(event.ofSearch),
        ofArtist: Optional.fromNullable(event.ofArtist),
        ofVideo: Optional.fromNullable(event.ofVideo),
        dances: danceViewModels,
        hasReachedMax: danceViewModels.isEmpty,
        error: const Optional.absent(),
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: DanceListStatus.loadingFailure,
        error: Optional.of(error),
      ));
    }
  }

  FutureOr<void> _onDanceListLoadMore(
    DanceListLoadMore event,
    Emitter<DanceListState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onDanceListLoadMore');

    try {
      emit(state.copyWith(
        status: DanceListStatus.loading,
        error: const Optional.absent(),
      ));

      final List<DanceViewModel> danceViewModels;
      danceViewModels = await _fetchDances(
        ofSearch: state.ofSearch,
        ofArtist: state.ofArtist,
        ofVideo: state.ofVideo,
        offset: state.dances.length,
      );

      emit(state.copyWith(
        status: DanceListStatus.loadingSuccess,
        dances: List.of(state.dances)..addAll(danceViewModels),
        hasReachedMax: danceViewModels.isEmpty,
        error: const Optional.absent(),
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: DanceListStatus.loadingFailure,
        error: Optional.of(error),
      ));
    }
  }

  FutureOr<void> _onDanceListRefresh(
    DanceListRefresh event,
    Emitter<DanceListState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onDanceListRefresh');

    try {
      emit(state.copyWith(
        status: DanceListStatus.refreshing,
      ));

      List<DanceViewModel> danceViewModels = await _fetchDances(
        ofSearch: state.ofSearch,
        ofArtist: state.ofArtist,
        ofVideo: state.ofVideo,
        offset: 0,
      );

      emit(state.copyWith(
        status: DanceListStatus.refreshingSuccess,
        dances: danceViewModels,
        hasReachedMax: false,
        error: const Optional.absent(),
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: DanceListStatus.refreshingFailure,
        error: Optional.of(error),
      ));
    }
  }

  FutureOr<void> _onDanceListSelect(
    DanceListSelect event,
    Emitter<DanceListState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onDanceListSelect');

    emit(state.copyWith(
      selectedDances: List.of(state.selectedDances)
        ..removeWhere((element) => element.id == event.dance.id)
        ..add(event.dance),
    ));
  }

  FutureOr<void> _onDanceListUnselect(
    DanceListUnselect event,
    Emitter<DanceListState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onDanceListUnselect');

    emit((event.dance != null)
        ? state.copyWith(
            selectedDances: List.of(state.selectedDances)
              ..removeWhere((element) => element.id == event.dance!.id),
          )
        : state.copyWith(
            selectedDances: [],
          ));
  }

  FutureOr<void> _onDanceListDelete(
    DanceListDelete event,
    Emitter<DanceListState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onDanceListSelect');

    if (state.selectedDances.isEmpty) return;

    try {
      for (DanceViewModel dance in state.selectedDances) {
        await danceRepository.deleteById(dance.id);
        emit(state.copyWith(
          status: DanceListStatus.deleteFailure,
          dances: List.of(state.dances)
            ..removeWhere((element) => element.id == dance.id),
          selectedDances: List.of(state.selectedDances)
            ..removeWhere((element) => element.id == dance.id),
          error: const Optional.absent(),
        ));
      }
    } on Error catch (error) {
      emit(state.copyWith(
        status: DanceListStatus.deleteFailure,
        error: Optional.of(error),
      ));
    }
  }

  Future<List<DanceViewModel>> _fetchDances({
    String? ofSearch,
    String? ofArtist,
    String? ofVideo,
    required int offset,
    int limit = 10,
  }) async {
    assert(ofSearch == null || (ofArtist == null && ofVideo == null));
    if (kDebugMode) print('$runtimeType:_fetchDances');

    List<DanceEntity> danceEntities;

    if (ofSearch != null) {
      danceEntities = await danceRepository.getListOfSearch(
        ofSearch,
        offset: Offset(
          offset: offset,
          limit: limit,
        ),
      );
    } else if (ofArtist != null) {
      danceEntities = await danceRepository.getDancesOfArtist(
        ofArtist,
        offset: Offset(
          offset: offset,
          limit: limit,
        ),
      );
    } else if (ofVideo != null) {
      danceEntities = await danceRepository.getDancesOfVideo(
        ofVideo,
        offset: Offset(
          offset: offset,
          limit: limit,
        ),
      );
    } else {
      danceEntities = await danceRepository.getList(
        offset: Offset(
          offset: offset,
          limit: limit,
        ),
      );
    }

    List<DanceViewModel> danceViewModels = danceEntities
        .map<DanceViewModel>(
            (danceEntity) => mapper.toDanceViewModel(danceEntity))
        .toList();
    return danceViewModels;
  }
}
