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
    on<MomentListSelect>(_onMomentListSelect);
    on<MomentListUnselect>(_onMomentListUnselect);
    on<MomentListDelete>(_onMomentListDelete);
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
        status: MomentListStatus.loadingSuccess,
        ofArtist: event.ofArtist,
        ofFigure: event.ofFigure,
        ofVideo: event.ofVideo,
        moments: momentViewModels,
        hasReachedMax: false,
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: MomentListStatus.loadingFailure,
        error: error,
      ));
    }
  }

  FutureOr<void> _onMomentListLoadMore(
    MomentListLoadMore event,
    Emitter<MomentListState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onMomentListLoadMore');

    try {
      emit(state.copyWith(
        status: MomentListStatus.loading,
      ));

      final List<MomentViewModel> momentViewModels;
      momentViewModels = await _fetchMoments(
        ofArtist: state.ofArtist,
        ofFigure: state.ofFigure,
        ofVideo: state.ofVideo,
        offset: state.moments.length,
      );

      emit(state.copyWith(
        status: MomentListStatus.loadingSuccess,
        moments: List.of(state.moments)..addAll(momentViewModels),
        hasReachedMax: momentViewModels.isEmpty,
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: MomentListStatus.loadingFailure,
        error: error,
      ));
    }
  }

  FutureOr<void> _onMomentListRefresh(
    MomentListRefresh event,
    Emitter<MomentListState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onMomentListRefresh');

    try {
      emit(state.copyWith(
        status: MomentListStatus.refreshing,
      ));

      List<MomentViewModel> momentViewModels = await _fetchMoments(
        ofArtist: state.ofArtist,
        ofFigure: state.ofFigure,
        ofVideo: state.ofVideo,
        offset: 0,
      );

      emit(state.copyWith(
        status: MomentListStatus.refreshingSuccess,
        moments: momentViewModels,
        hasReachedMax: false,
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: MomentListStatus.refreshingFailure,
        error: error,
      ));
    }
  }

  FutureOr<void> _onMomentListSelect(
    MomentListSelect event,
    Emitter<MomentListState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onMomentListSelect');

    emit(state.copyWith(
      selectedMoments: List.of(state.selectedMoments)
        ..removeWhere((element) => element.id == event.moment.id)
        ..add(event.moment),
    ));
  }

  FutureOr<void> _onMomentListUnselect(
    MomentListUnselect event,
    Emitter<MomentListState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onMomentListUnselect');

    emit((event.moment != null)
        ? state.copyWith(
      selectedMoments: List.of(state.selectedMoments)
              ..removeWhere((element) => element.id == event.moment!.id),
          )
        : state.copyWith(
            selectedMoments: [],
          ));
  }

  FutureOr<void> _onMomentListDelete(
    MomentListDelete event,
    Emitter<MomentListState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onMomentListSelect');

    if (state.selectedMoments.isEmpty) return;
    try {
      for (MomentViewModel moment in state.selectedMoments) {
        await momentRepository.deleteById(moment.id);
        emit(state.copyWith(
          status: MomentListStatus.deleteSuccess,
          moments: List.of(state.moments)
            ..removeWhere((element) => element.id == moment.id),
          selectedMoments: List.of(state.selectedMoments)
            ..removeWhere((element) => element.id == moment.id),
        ));
      }
    } on Error catch (error) {
      emit(state.copyWith(
        status: MomentListStatus.deleteFailure,
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
    if (kDebugMode) print('$runtimeType:_fetchMoments');

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
            (momentEntity) => mapper.toMomentViewModel(momentEntity))
        .toList();
    return momentViewModels;
  }
}
