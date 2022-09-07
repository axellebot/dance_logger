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
        ofDance: event.ofDance,
        ofFigure: event.ofFigure,
        ofVideo: event.ofVideo,
        offset: 0,
      );

      emit(state.copyWith(
        status: ArtistListStatus.loadingSuccess,
        ofSearch: Optional.fromNullable(event.ofSearch),
        ofDance: Optional.fromNullable(event.ofDance),
        ofFigure: Optional.fromNullable(event.ofFigure),
        ofVideo: Optional.fromNullable(event.ofVideo),
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
        ofDance: state.ofDance,
        ofFigure: state.ofFigure,
        ofVideo: state.ofVideo,
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
        ofDance: state.ofDance,
        ofFigure: state.ofFigure,
        ofVideo: state.ofVideo,
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

    emit(state.copyWith(
      selectedArtists: List.of(state.selectedArtists)
        ..removeWhere((element) => element.id == event.artist.id)
        ..add(event.artist),
    ));
  }

  FutureOr<void> _onArtistListUnselect(
    ArtistListUnselect event,
    Emitter<ArtistListState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onArtistListUnselect');

    emit((event.artist != null)
        ? state.copyWith(
      selectedArtists: List.of(state.selectedArtists)
              ..removeWhere((element) => element.id == event.artist!.id),
          )
        : state.copyWith(
            selectedArtists: [],
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
    String? ofDance,
    String? ofFigure,
    String? ofVideo,
    required int offset,
    int limit = 10,
  }) async {
    assert(ofSearch == null ||
        (ofDance == null && ofFigure == null && ofVideo == null));
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
    } else if (ofDance != null) {
      artistEntities = await artistRepository.getArtistsOfDance(
        ofDance,
        offset: Offset(
          offset: offset,
          limit: limit,
        ),
      );
    } else if (ofVideo != null) {
      artistEntities = await artistRepository.getArtistsOfVideo(
        ofVideo,
        offset: Offset(
          offset: offset,
          limit: limit,
        ),
      );
    } else if (ofFigure != null) {
      artistEntities = await artistRepository.getArtistsOfFigure(
        ofFigure,
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
