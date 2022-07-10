import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FigureListBloc extends Bloc<FigureListEvent, FigureListState> {
  final FigureRepository figureRepository;
  final ModelMapper mapper;

  FigureListBloc({
    required this.figureRepository,
    required this.mapper,
  }) : super(const FigureListUninitialized()) {
    on<FigureListLoad>((event, emit) async {
      if (state is FigureListUninitialized) {
        final List<FigureViewModel> figureViewModels;
        figureViewModels = await _fetchFigures(
          ofArtist: event.ofArtist,
          ofDance: event.ofDance,
          ofVideo: event.ofVideo,
          offset: 0,
        );
        emit(FigureListLoaded(
          ofArtist: event.ofArtist,
          ofDance: event.ofDance,
          ofVideo: event.ofVideo,
          figures: figureViewModels,
          hasReachedMax: figureViewModels.isEmpty,
        ));
      }
    });
    on<FigureListLoadMore>((event, emit) async {
      final List<FigureViewModel> figureViewModels;

      if (state is FigureListLoaded) {
        figureViewModels = await _fetchFigures(
          ofArtist: (state as FigureListLoaded).ofArtist,
          ofDance: (state as FigureListLoaded).ofDance,
          ofVideo: (state as FigureListLoaded).ofVideo,
          offset: (state as FigureListLoaded).figures.length,
        );
        if (figureViewModels.isNotEmpty) {
          emit((state as FigureListLoaded).copyWith(
            figures: (state as FigureListLoaded).figures + figureViewModels,
            hasReachedMax: false,
          ));
        } else {
          emit((state as FigureListLoaded).copyWith(
            hasReachedMax: true,
          ));
        }
      }
    });

    on<FigureListRefresh>((event, emit) async {
      if (state is FigureListLoaded) {
        List<FigureViewModel> figureViewModels = await _fetchFigures(
          ofArtist: (state as FigureListLoaded).ofArtist,
          ofDance: (state as FigureListLoaded).ofDance,
          ofVideo: (state as FigureListLoaded).ofVideo,
          offset: 0,
        );

        emit((state as FigureListLoaded).copyWith(
          figures: figureViewModels,
          hasReachedMax: false,
        ));
      }
    });
  }

  Future<List<FigureViewModel>> _fetchFigures({
    String? ofArtist,
    String? ofDance,
    String? ofVideo,
    required int offset,
    int limit = 10,
  }) async {
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
