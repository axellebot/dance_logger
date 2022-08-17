import 'dart:async';

import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      ));

      final List<DanceViewModel> danceViewModels;
      danceViewModels = await _fetchDances(
        ofArtist: event.ofArtist,
        offset: 0,
      );

      emit(state.copyWith(
        status: DanceListStatus.success,
        ofArtist: event.ofArtist,
        ofVideo: event.ofVideo,
        dances: danceViewModels,
        hasReachedMax: danceViewModels.isEmpty,
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: DanceListStatus.failure,
        error: error,
      ));
    }
  }

  FutureOr<void> _onDanceListLoadMore(
    DanceListLoadMore event,
    Emitter<DanceListState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onDanceListLoadMore');
    if (state.status != DanceListStatus.success) return;
    try {
      final List<DanceViewModel> danceViewModels;
      danceViewModels = await _fetchDances(
        ofArtist: state.ofArtist,
        offset: state.dances.length,
      );
      if (danceViewModels.isNotEmpty) {
        emit(state.copyWith(
          dances: List.of(state.dances)..addAll(danceViewModels),
          hasReachedMax: false,
        ));
      } else {
        emit(state.copyWith(
          hasReachedMax: true,
        ));
      }
    } on Error catch (error) {
      emit(state.copyWith(
        status: DanceListStatus.failure,
        error: error,
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
        ofArtist: state.ofArtist,
        offset: 0,
      );

      emit(state.copyWith(
        status: DanceListStatus.success,
        dances: danceViewModels,
        hasReachedMax: false,
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: DanceListStatus.failure,
        error: error,
      ));
    }
  }

  FutureOr<void> _onDanceListSelect(
    DanceListSelect event,
    Emitter<DanceListState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onDanceListSelect');

    emit(state.copyWith(
      selectedDances: List.of(state.selectedDances)..add(event.danceId),
    ));
  }

  FutureOr<void> _onDanceListUnselect(
    DanceListUnselect event,
    Emitter<DanceListState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onDanceListUnselect');

    emit((event.danceId != null)
        ? state.copyWith(
            selectedDances: List.of(state.selectedDances)
              ..remove(event.danceId),
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
      for (String danceId in state.selectedDances) {
        await danceRepository.deleteById(danceId);
        emit(state.copyWith(
          dances: List.of(state.dances)
            ..removeWhere((element) => element.id == danceId),
          selectedDances: List.of(state.selectedDances)..remove(danceId),
        ));
      }
    } on Error catch (error) {
      emit(state.copyWith(
        status: DanceListStatus.failure,
        error: error,
      ));
    }
  }

  Future<List<DanceViewModel>> _fetchDances({
    String? ofArtist,
    required int offset,
    int limit = 10,
  }) async {
    if (kDebugMode) print('$runtimeType:_fetchDances');
    List<DanceEntity> danceEntities;

    if (ofArtist != null) {
      danceEntities = await danceRepository.getDancesOfArtist(
        ofArtist,
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
