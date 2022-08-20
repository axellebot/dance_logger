import 'dart:async';

import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        status: ArtistListStatus.success,
        ofSearch: state.ofSearch,
        ofDance: event.ofDance,
        ofFigure: event.ofFigure,
        ofVideo: event.ofVideo,
        artists: artistViewModels,
        hasReachedMax: false,
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: ArtistListStatus.failure,
        error: error,
      ));
    }
  }

  FutureOr<void> _onArtistListLoadMore(
    ArtistListLoadMore event,
    Emitter<ArtistListState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onArtistListLoadMore');
    if (state.status != ArtistListStatus.success) return;
    try {
      final List<ArtistViewModel> artistViewModels;
      artistViewModels = await _fetchArtists(
        ofSearch: state.ofSearch,
        ofDance: state.ofDance,
        ofFigure: state.ofFigure,
        ofVideo: state.ofVideo,
        offset: state.artists.length,
      );
      if (artistViewModels.isNotEmpty) {
        emit(state.copyWith(
          artists: List.of(state.artists)..addAll(artistViewModels),
          hasReachedMax: false,
        ));
      } else {
        emit(state.copyWith(
          hasReachedMax: true,
        ));
      }
    } on Error catch (error) {
      emit(state.copyWith(
        status: ArtistListStatus.failure,
        error: error,
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
        status: ArtistListStatus.success,
        artists: artistViewModels,
        hasReachedMax: false,
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: ArtistListStatus.failure,
        error: error,
      ));
    }
  }

  FutureOr<void> _onArtistListSelect(
    ArtistListSelect event,
    Emitter<ArtistListState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onArtistListSelect');

    emit(state.copyWith(
      selectedArtists: List.of(state.selectedArtists)..add(event.artistId),
    ));
  }

  FutureOr<void> _onArtistListUnselect(
    ArtistListUnselect event,
    Emitter<ArtistListState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onArtistListUnselect');

    emit((event.artistId != null)
        ? state.copyWith(
            selectedArtists: List.of(state.selectedArtists)
              ..remove(event.artistId),
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
      for (String artistId in state.selectedArtists) {
        await artistRepository.deleteById(artistId);
        emit(state.copyWith(
          artists: List.of(state.artists)
            ..removeWhere((element) => element.id == artistId),
          selectedArtists: List.of(state.selectedArtists)..remove(artistId),
        ));
      }
    } on Error catch (error) {
      emit(state.copyWith(
        status: ArtistListStatus.failure,
        error: error,
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
