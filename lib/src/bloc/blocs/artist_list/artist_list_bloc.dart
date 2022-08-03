import 'dart:async';

import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
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
  }

  FutureOr<void> _onArtistListLoad(event, emit) async {
    final List<ArtistViewModel> artistViewModels;
    artistViewModels = await _fetchArtists(
      ofDance: event.ofDance,
      ofFigure: event.ofFigure,
      ofVideo: event.ofVideo,
      offset: 0,
    );
    emit(state.copyWith(
      status: ArtistListStatus.success,
      artists: artistViewModels,
      hasReachedMax: false,
    ));
  }

  FutureOr<void> _onArtistListLoadMore(event, emit) async {
    if (state.status == ArtistListStatus.success) {
      final List<ArtistViewModel> artistViewModels;
      artistViewModels = await _fetchArtists(
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
    }
  }

  FutureOr<void> _onArtistListRefresh(event, emit) async {
    if (state.status == ArtistListStatus.success) {
      emit(state.copyWith(
        status: ArtistListStatus.loading,
      ));

      List<ArtistViewModel> artistViewModels = await _fetchArtists(
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
    }
  }

  Future<List<ArtistViewModel>> _fetchArtists({
    String? ofDance,
    String? ofFigure,
    String? ofVideo,
    required int offset,
    int limit = 10,
  }) async {
    List<ArtistEntity> artistEntities;

    if (ofDance != null) {
      artistEntities = await artistRepository.getArtistsOfDance(
        ofDance,
        offset: Offset(
          offset: offset,
          limit: limit,
        ),
      );
    } else if (ofVideo != null) {
      artistEntities = await artistRepository.getArtistOfVideo(
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
