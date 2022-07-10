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
  }) : super(const DanceListUninitialized()) {
    on<DanceListLoad>((event, emit) async {
      if (state is DanceListUninitialized) {
        final List<DanceViewModel> danceViewModels;
        danceViewModels = await _fetchDances(
          ofArtist: event.ofArtist,
          offset: 0,
        );
        emit(DanceListLoaded(
          ofArtist: event.ofArtist,
          dances: danceViewModels,
          hasReachedMax: danceViewModels.isEmpty,
        ));
      }
    });
    on<DanceListLoadMore>((event, emit) async {
      final List<DanceViewModel> danceViewModels;

      if (state is DanceListLoaded) {
        danceViewModels = await _fetchDances(
          ofArtist: (state as DanceListLoaded).ofArtist,
          offset: (state as DanceListLoaded).dances.length,
        );
        if (danceViewModels.isNotEmpty) {
          emit((state as DanceListLoaded).copyWith(
            dances: (state as DanceListLoaded).dances + danceViewModels,
            hasReachedMax: false,
          ));
        } else {
          emit((state as DanceListLoaded).copyWith(
            hasReachedMax: true,
          ));
        }
      }
    });

    on<DanceListRefresh>((event, emit) async {
      if (state is DanceListLoaded) {
        List<DanceViewModel> danceViewModels = await _fetchDances(
          ofArtist: (state as DanceListLoaded).ofArtist,
          offset: 0,
        );

        emit((state as DanceListLoaded).copyWith(
          dances: danceViewModels,
          hasReachedMax: false,
        ));
      }
    });
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
