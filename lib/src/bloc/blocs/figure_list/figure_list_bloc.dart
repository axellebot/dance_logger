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
    on<FigureListSelect>(_onFigureListSelect);
    on<FigureListUnselect>(_onFigureListUnselect);
    on<FigureListDelete>(_onFigureListDelete);
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
        ofArtistId: event.ofArtistId,
        ofDanceId: event.ofDanceId,
        ofVideoId: event.ofVideoId,
        offset: 0,
      );

      emit(state.copyWith(
        status: FigureListStatus.loadingSuccess,
        ofArtistId: event.ofArtistId,
        ofDanceId: event.ofDanceId,
        ofVideoId: event.ofVideoId,
        figures: figureViewModels,
        hasReachedMax: figureViewModels.isEmpty,
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: FigureListStatus.loadingFailure,
        error: error,
      ));
    }
  }

  FutureOr<void> _onFigureListLoadMore(
    FigureListLoadMore event,
    Emitter<FigureListState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onFigureListLoadMore');

    try {
      emit(state.copyWith(
        status: FigureListStatus.loading,
      ));

      final List<FigureViewModel> figureViewModels;
      figureViewModels = await _fetchFigures(
        ofArtistId: state.ofArtistId,
        ofDanceId: state.ofDanceId,
        ofVideoId: state.ofVideoId,
        offset: state.figures.length,
      );

      emit(state.copyWith(
        status: FigureListStatus.loadingSuccess,
        figures: List.of(state.figures)..addAll(figureViewModels),
        hasReachedMax: figureViewModels.isEmpty,
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: FigureListStatus.loadingFailure,
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
        status: FigureListStatus.refreshing,
      ));

      List<FigureViewModel> figureViewModels = await _fetchFigures(
        ofArtistId: state.ofArtistId,
        ofDanceId: state.ofDanceId,
        ofVideoId: state.ofVideoId,
        offset: 0,
      );

      emit(state.copyWith(
        status: FigureListStatus.refreshingSuccess,
        figures: figureViewModels,
        hasReachedMax: false,
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: FigureListStatus.refreshingFailure,
        error: error,
      ));
    }
  }

  FutureOr<void> _onFigureListSelect(
    FigureListSelect event,
    Emitter<FigureListState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onFigureListSelect');

    final newSelectedFigures = List.of(state.selectedFigures);
    for (FigureViewModel figure in event.figures) {
      newSelectedFigures.removeWhere((element) => element.id == figure.id);
    }
    newSelectedFigures.addAll(event.figures);

    emit(state.copyWith(
      selectedFigures: newSelectedFigures,
    ));
  }

  FutureOr<void> _onFigureListUnselect(
    FigureListUnselect event,
    Emitter<FigureListState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onFigureListUnselect');

    if (event.figures == null) {
      return emit(state.copyWith(
        selectedFigures: [],
      ));
    }

    final newSelectedFigures = List.of(state.selectedFigures);
    for (FigureViewModel figure in event.figures!) {
      newSelectedFigures.removeWhere((element) => element.id == figure.id);
    }

    emit(state.copyWith(
      selectedFigures: newSelectedFigures,
    ));
  }

  FutureOr<void> _onFigureListDelete(
    FigureListDelete event,
    Emitter<FigureListState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onFigureListSelect');

    if (state.selectedFigures.isEmpty) return;
    try {
      for (FigureViewModel figure in state.selectedFigures) {
        await figureRepository.deleteById(figure.id);
        emit(state.copyWith(
          status: FigureListStatus.deleteSuccess,
          figures: List.of(state.figures)
            ..removeWhere((element) => element.id == figure.id),
          selectedFigures: List.of(state.selectedFigures)
            ..removeWhere((element) => element.id == figure.id),
        ));
      }
    } on Error catch (error) {
      emit(state.copyWith(
        status: FigureListStatus.deleteFailure,
        error: error,
      ));
    }
  }

  Future<List<FigureViewModel>> _fetchFigures({
    String? ofArtistId,
    String? ofDanceId,
    String? ofVideoId,
    required int offset,
    int limit = 10,
  }) async {
    if (kDebugMode) print('$runtimeType:_fetchFigures');

    List<FigureEntity> figureEntities;
    if (ofArtistId != null) {
      figureEntities = await figureRepository.getFiguresOfArtist(
        ofArtistId,
        offset: Offset(
          offset: offset,
          limit: limit,
        ),
      );
    } else if (ofDanceId != null) {
      figureEntities = await figureRepository.getFiguresOfDance(
        ofDanceId,
        offset: Offset(
          offset: offset,
          limit: limit,
        ),
      );
    } else if (ofVideoId != null) {
      figureEntities = await figureRepository.getFiguresOfVideo(
        ofVideoId,
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
