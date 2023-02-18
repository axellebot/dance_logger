import 'dart:async';

import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiver/core.dart';

class ArtistListBloc extends Bloc<ArtistListEvent, ArtistListState> {
  final ArtistRepository artistRepository;
  final ModelMapper mapper;

  ArtistListBloc({
    required this.artistRepository,
    required this.mapper,
  }) : super(const ArtistListState()) {
    on<ArtistListLoad>(_onArtistListLoad);
    on<ArtistListLoadMore>(_onArtistListLoadMore);
    on<ArtistListRefresh>(_onArtistListRefresh);
    on<ArtistListSelect>(_onArtistListSelect);
    on<ArtistListUnselect>(_onArtistListUnselect);
    on<ArtistListDelete>(_onArtistListDelete);
  }

  FutureOr<void> _onArtistListLoad(
    ArtistListLoad event,
    Emitter<ArtistListState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onArtistListLoad');

    try {
      emit(state.copyWith(
        status: ArtistListStatus.loading,
      ));

      final List<ArtistViewModel> artistViewModels;
      artistViewModels = await _fetchArtists(
        ofSearch: event.ofSearch,
        ofDanceId: event.ofDanceId,
        ofFigureId: event.ofFigureId,
        ofVideoId: event.ofVideoId,
        offset: 0,
      );

      emit(state.copyWith(
        status: ArtistListStatus.loadingSuccess,
        ofSearch: Optional.fromNullable(event.ofSearch),
        ofDanceId: Optional.fromNullable(event.ofDanceId),
        ofFigureId: Optional.fromNullable(event.ofFigureId),
        ofVideoId: Optional.fromNullable(event.ofVideoId),
        artists: artistViewModels,
        hasReachedMax: false,
        error: const Optional.absent(),
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: ArtistListStatus.loadingFailure,
        error: Optional.of(error),
      ));
    }
  }

  FutureOr<void> _onArtistListLoadMore(
    ArtistListLoadMore event,
    Emitter<ArtistListState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onArtistListLoadMore');

    try {
      emit(state.copyWith(
        status: ArtistListStatus.loading,
      ));

      final List<ArtistViewModel> artistViewModels;
      artistViewModels = await _fetchArtists(
        ofSearch: state.ofSearch,
        ofDanceId: state.ofDanceId,
        ofFigureId: state.ofFigureId,
        ofVideoId: state.ofVideoId,
        offset: state.artists.length,
      );

      emit(state.copyWith(
        status: ArtistListStatus.loadingSuccess,
        artists: List.of(state.artists)..addAll(artistViewModels),
        hasReachedMax: artistViewModels.isEmpty,
        error: const Optional.absent(),
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: ArtistListStatus.loadingFailure,
        error: Optional.of(error),
      ));
    }
  }

  FutureOr<void> _onArtistListRefresh(
    ArtistListRefresh event,
    Emitter<ArtistListState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onArtistListRefresh');

    try {
      emit(state.copyWith(
        status: ArtistListStatus.refreshing,
      ));

      List<ArtistViewModel> artistViewModels = await _fetchArtists(
        ofSearch: state.ofSearch,
        ofDanceId: state.ofDanceId,
        ofFigureId: state.ofFigureId,
        ofVideoId: state.ofVideoId,
        offset: 0,
      );

      emit(state.copyWith(
        status: ArtistListStatus.refreshingSuccess,
        artists: artistViewModels,
        hasReachedMax: false,
        error: const Optional.absent(),
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: ArtistListStatus.refreshingFailure,
        error: Optional.of(error),
      ));
    }
  }

  FutureOr<void> _onArtistListSelect(
    ArtistListSelect event,
    Emitter<ArtistListState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onArtistListSelect');

    final newSelectedArtists = List.of(state.selectedArtists);
    for (ArtistViewModel artist in event.artists) {
      newSelectedArtists.removeWhere((element) => element.id == artist.id);
    }
    newSelectedArtists.addAll(event.artists);

    emit(state.copyWith(
      selectedArtists: newSelectedArtists,
    ));
  }

  FutureOr<void> _onArtistListUnselect(
    ArtistListUnselect event,
    Emitter<ArtistListState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onArtistListUnselect');

    if (event.artists == null) {
      return emit(state.copyWith(
        selectedArtists: [],
      ));
    }

    final newSelectedArtists = List.of(state.selectedArtists);
    for (ArtistViewModel artist in event.artists!) {
      newSelectedArtists.removeWhere((element) => element.id == artist.id);
    }

    emit(state.copyWith(
      selectedArtists: newSelectedArtists,
    ));
  }

  FutureOr<void> _onArtistListDelete(
    ArtistListDelete event,
    Emitter<ArtistListState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onArtistListSelect');

    if (state.selectedArtists.isEmpty) return;
    try {
      for (ArtistViewModel artist in state.selectedArtists) {
        await artistRepository.deleteById(artist.id);
        emit(state.copyWith(
          status: ArtistListStatus.deleteSuccess,
          artists: List.of(state.artists)
            ..removeWhere((element) => element.id == artist.id),
          selectedArtists: List.of(state.selectedArtists)
            ..removeWhere((element) => element.id == artist.id),
          error: const Optional.absent(),
        ));
      }
    } on Error catch (error) {
      emit(state.copyWith(
        status: ArtistListStatus.deleteFailure,
        error: Optional.of(error),
      ));
    }
  }

  Future<List<ArtistViewModel>> _fetchArtists({
    String? ofSearch,
    String? ofDanceId,
    String? ofFigureId,
    String? ofVideoId,
    required int offset,
    int limit = 10,
  }) async {
    assert(ofSearch == null ||
        (ofDanceId == null && ofFigureId == null && ofVideoId == null));
    if (kDebugMode) print('$runtimeType:_fetchArtists');

    List<ArtistEntity> artistEntities;

    if (ofSearch != null) {
      artistEntities = await artistRepository.getListOfSearch(
        ofSearch,
        offset: Offset(
          offset: offset,
          limit: limit,
        ),
      );
    } else if (ofDanceId != null) {
      artistEntities = await artistRepository.getArtistsOfDance(
        ofDanceId,
        offset: Offset(
          offset: offset,
          limit: limit,
        ),
      );
    } else if (ofVideoId != null) {
      artistEntities = await artistRepository.getArtistsOfVideo(
        ofVideoId,
        offset: Offset(
          offset: offset,
          limit: limit,
        ),
      );
    } else if (ofFigureId != null) {
      artistEntities = await artistRepository.getArtistsOfFigure(
        ofFigureId,
        offset: Offset(
          offset: offset,
          limit: limit,
        ),
      );
    } else {
      artistEntities = await artistRepository.getList(
        offset: Offset(
          offset: offset,
          limit: limit,
        ),
      );
    }

    List<ArtistViewModel> artistViewModels = artistEntities
        .map<ArtistViewModel>(
            (artistEntity) => mapper.toArtistViewModel(artistEntity))
        .toList();
    return artistViewModels;
  }
}
