import 'dart:async';

import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FigureListBloc extends Bloc<FigureListEvent, FigureListState> {
  final FigureRepository figureRepository;
  final ModelMapper mapper;

  FigureListBloc({
    required this.figureRepository,
    required this.mapper,
  }) : super(const FigureListState()) {
    on<FigureListLoad>(_onFigureListLoad);
    on<FigureListLoadMore>(_onFigureListLoadMore);
    on<FigureListRefresh>(_onFigureListRefresh);
  }

  FutureOr<void> _onFigureListLoad(
    FigureListLoad event,
    Emitter<FigureListState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onFigureListLoad');
    try {
      emit(state.copyWith(
        status: FigureListStatus.loading,
      ));

      final List<FigureViewModel> figureViewModels;
      figureViewModels = await _fetchFigures(
        ofArtist: event.ofArtist,
        ofDance: event.ofDance,
        ofVideo: event.ofVideo,
        offset: 0,
      );

      emit(state.copyWith(
        status: FigureListStatus.success,
        ofArtist: event.ofArtist,
        ofDance: event.ofDance,
        ofVideo: event.ofVideo,
        figures: figureViewModels,
        hasReachedMax: figureViewModels.isEmpty,
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: FigureListStatus.failure,
        error: error,
      ));
    }
  }

  FutureOr<void> _onFigureListLoadMore(
    FigureListLoadMore event,
    Emitter<FigureListState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onFigureListLoadMore');
    if (state.status != FigureListStatus.success) return;
    try {
      final List<FigureViewModel> figureViewModels;

      figureViewModels = await _fetchFigures(
        ofArtist: state.ofArtist,
        ofDance: state.ofDance,
        ofVideo: state.ofVideo,
        offset: state.figures.length,
      );
      if (figureViewModels.isNotEmpty) {
        emit(state.copyWith(
          figures: List.of(state.figures)..addAll(figureViewModels),
          hasReachedMax: false,
        ));
      } else {
        emit(state.copyWith(
          hasReachedMax: true,
        ));
      }
    } on Error catch (error) {
      emit(state.copyWith(
        status: FigureListStatus.failure,
        error: error,
      ));
    }
  }

  FutureOr<void> _onFigureListRefresh(
    FigureListRefresh event,
    Emitter<FigureListState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onFigureListRefresh');
    try {
      emit(state.copyWith(
        status: FigureListStatus.loading,
      ));

      List<FigureViewModel> figureViewModels = await _fetchFigures(
        ofArtist: state.ofArtist,
        ofDance: state.ofDance,
        ofVideo: state.ofVideo,
        offset: 0,
      );

      emit(state.copyWith(
        status: FigureListStatus.success,
        figures: figureViewModels,
        hasReachedMax: false,
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: FigureListStatus.failure,
        error: error,
      ));
    }
  }

  Future<List<FigureViewModel>> _fetchFigures({
    String? ofArtist,
    String? ofDance,
    String? ofVideo,
    required int offset,
    int limit = 10,
  }) async {
    if (kDebugMode) print('$runtimeType:_fetchFigures');
    List<FigureEntity> figureEntities;

    if (ofArtist != null) {
      figureEntities = await figureRepository.getFiguresOfArtist(
        ofArtist,
        offset: Offset(
          offset: offset,
          limit: limit,
        ),
      );
    } else if (ofDance != null) {
      figureEntities = await figureRepository.getFiguresOfDance(
        ofDance,
        offset: Offset(
          offset: offset,
          limit: limit,
        ),
      );
    } else if (ofVideo != null) {
      figureEntities = await figureRepository.getFiguresOfVideo(
        ofVideo,
        offset: Offset(
          offset: offset,
          limit: limit,
        ),
      );
    } else {
      figureEntities = await figureRepository.getList(
        offset: Offset(
          offset: offset,
          limit: limit,
        ),
      );
    }

    List<FigureViewModel> figureViewModels = figureEntities
        .map<FigureViewModel>(
            (figureEntity) => mapper.toFigureViewModel(figureEntity))
        .toList();
    return figureViewModels;
  }
}
