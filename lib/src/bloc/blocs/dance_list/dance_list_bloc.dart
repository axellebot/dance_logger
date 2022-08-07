import 'dart:async';

import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
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
  }

  FutureOr<void> _onDanceListLoad(event, emit) async {
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
      dances: danceViewModels,
      hasReachedMax: danceViewModels.isEmpty,
    ));
  }

  FutureOr<void> _onDanceListLoadMore(event, emit) async {
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

  FutureOr<void> _onDanceListRefresh(event, emit) async {
    try {
      emit(state.copyWith(
        status: DanceListStatus.loading,
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

  Future<List<DanceViewModel>> _fetchDances({
    String? ofArtist,
    required int offset,
    int limit = 10,
  }) async {
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
