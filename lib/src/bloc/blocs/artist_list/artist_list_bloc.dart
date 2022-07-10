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
  }) : super(const ArtistListUninitialized()) {
    on<ArtistListLoad>((event, emit) async {
      if (state is ArtistListUninitialized) {
        final List<ArtistViewModel> artistViewModels;
        artistViewModels = await _fetchArtists(
          ofDance: event.ofDance,
          ofFigure: event.ofFigure,
          ofVideo: event.ofVideo,
          offset: 0,
        );
        emit(ArtistListLoaded(
          ofDance: event.ofDance,
          ofFigure: event.ofFigure,
          ofVideo: event.ofVideo,
          artists: artistViewModels,
          hasReachedMax: false,
        ));
      }
    });
    on<ArtistListLoadMore>((event, emit) async {
      if (state is ArtistListLoaded) {
        final List<ArtistViewModel> artistViewModels;
        artistViewModels = await _fetchArtists(
          ofDance: (state as ArtistListLoaded).ofDance,
          ofFigure: (state as ArtistListLoaded).ofFigure,
          ofVideo: (state as ArtistListLoaded).ofVideo,
          offset: (state as ArtistListLoaded).artists.length,
        );
        if (artistViewModels.isNotEmpty) {
          emit((state as ArtistListLoaded).copyWith(
            artists: (state as ArtistListLoaded).artists + artistViewModels,
            hasReachedMax: false,
          ));
        } else {
          emit((state as ArtistListLoaded).copyWith(
            hasReachedMax: true,
          ));
        }
      }
    });

    on<ArtistListRefresh>((event, emit) async {
      if (state is ArtistListLoaded) {
        List<ArtistViewModel> artistViewModels = await _fetchArtists(
          ofDance: (state as ArtistListLoaded).ofDance,
          ofFigure: (state as ArtistListLoaded).ofFigure,
          ofVideo: (state as ArtistListLoaded).ofVideo,
          offset: 0,
        );

        emit((state as ArtistListLoaded).copyWith(
          artists: artistViewModels,
          hasReachedMax: false,
        ));
      }
    });
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
