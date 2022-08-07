import 'dart:async';

import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MomentListBloc extends Bloc<MomentListEvent, MomentListState> {
  final MomentRepository momentRepository;
  final ModelMapper mapper;

  MomentListBloc({
    required this.momentRepository,
    required this.mapper,
  }) : super(const MomentListUninitialized()) {
    on<MomentListLoad>(_onMomentListLoad);
    on<MomentListLoadMore>(_onMomentListLoadMore);
    on<MomentListRefresh>(_onMomentListRefresh);
  }

  FutureOr<void> _onMomentListLoad(event, emit) async {
    final List<MomentViewModel> momentViewModels;
    momentViewModels = await _fetchTimes(
      ofArtist: event.ofArtist,
      ofFigure: event.ofFigure,
      ofVideo: event.ofVideo,
      offset: 0,
    );
    emit(MomentListLoaded(
      ofArtist: event.ofArtist,
      ofFigure: event.ofFigure,
      ofVideo: event.ofVideo,
      times: momentViewModels,
      hasReachedMax: false,
    ));
  }

  FutureOr<void> _onMomentListLoadMore(event, emit) async {
    if (state is MomentListLoaded) {
      final List<MomentViewModel> momentViewModels;
      momentViewModels = await _fetchTimes(
        ofArtist: (state as MomentListLoaded).ofArtist,
        ofFigure: (state as MomentListLoaded).ofFigure,
        ofVideo: (state as MomentListLoaded).ofVideo,
        offset: (state as MomentListLoaded).times.length,
      );
      if (momentViewModels.isNotEmpty) {
        emit((state as MomentListLoaded).copyWith(
          times: (state as MomentListLoaded).times + momentViewModels,
          hasReachedMax: false,
        ));
      } else {
        emit((state as MomentListLoaded).copyWith(
          hasReachedMax: true,
        ));
      }
    }
  }

  FutureOr<void> _onMomentListRefresh(event, emit) async {
    if (state is MomentListLoaded) {
      List<MomentViewModel> momentViewModels = await _fetchTimes(
        ofArtist: (state as MomentListLoaded).ofArtist,
        ofFigure: (state as MomentListLoaded).ofFigure,
        ofVideo: (state as MomentListLoaded).ofVideo,
        offset: 0,
      );

      emit((state as MomentListLoaded).copyWith(
        times: momentViewModels,
        hasReachedMax: false,
      ));
    }
  }

  Future<List<MomentViewModel>> _fetchTimes({
    String? ofArtist,
    String? ofFigure,
    String? ofVideo,
    required int offset,
    int limit = 10,
  }) async {
    List<MomentEntity> timeEntities;

    if (ofArtist != null) {
      timeEntities = await momentRepository.getMomentsOfArtist(
        ofArtist,
        offset: Offset(
          offset: offset,
          limit: limit,
        ),
      );
    } else if (ofFigure != null) {
      timeEntities = await momentRepository.getMomentsOfFigure(
        ofFigure,
        offset: Offset(
          offset: offset,
          limit: limit,
        ),
      );
    } else if (ofVideo != null) {
      timeEntities = await momentRepository.getMomentsOfVideo(
        ofVideo,
        offset: Offset(
          offset: offset,
          limit: limit,
        ),
      );
    } else {
      timeEntities = await momentRepository.getList(
        offset: Offset(
          offset: offset,
          limit: limit,
        ),
      );
    }

    List<MomentViewModel> momentViewModels = timeEntities
        .map<MomentViewModel>((timeEntity) => mapper.tomomentViewModel(timeEntity))
        .toList();
    return momentViewModels;
  }
}
