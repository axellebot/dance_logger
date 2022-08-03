import 'dart:async';

import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PracticeListBloc extends Bloc<PracticeListEvent, PracticeListState> {
  final PracticeRepository practiceRepository;
  final ModelMapper mapper;

  PracticeListBloc({
    required this.practiceRepository,
    required this.mapper,
  }) : super(const PracticeListUninitialized()) {
    on<PracticeListLoad>(_onPracticeListLoad);
    on<PracticeListLoadMore>(_onPracticeListLoadMore);
    on<PracticeListRefresh>(_onPracticeListRefresh);
  }

  FutureOr<void> _onPracticeListLoad(event, emit) async {
    final List<PracticeViewModel> practiceViewModels;
    practiceViewModels = await _fetchPractices(
      ofDance: event.ofDance,
      ofFigure: event.ofFigure,
      ofVideo: event.ofVideo,
      offset: 0,
    );
    emit(PracticeListLoaded(
      ofDance: event.ofDance,
      ofFigure: event.ofFigure,
      ofVideo: event.ofVideo,
      practices: practiceViewModels,
      hasReachedMax: false,
    ));
  }

  FutureOr<void> _onPracticeListLoadMore(event, emit) async {
    if (state is PracticeListLoaded) {
      List<PracticeViewModel> practiceViewModels;

      practiceViewModels = await _fetchPractices(
        ofArtist: (state as PracticeListLoaded).ofArtist,
        ofDance: (state as PracticeListLoaded).ofDance,
        ofFigure: (state as PracticeListLoaded).ofFigure,
        ofVideo: (state as PracticeListLoaded).ofVideo,
        offset: (state as PracticeListLoaded).practices.length,
      );
      if (practiceViewModels.isNotEmpty) {
        emit((state as PracticeListLoaded).copyWith(
          practices:
              (state as PracticeListLoaded).practices + practiceViewModels,
          hasReachedMax: false,
        ));
      } else {
        emit((state as PracticeListLoaded).copyWith(
          hasReachedMax: true,
        ));
      }
    }
  }

  FutureOr<void> _onPracticeListRefresh(event, emit) async {
    if (state is PracticeListLoaded) {
      List<PracticeViewModel> practiceViewModels = await _fetchPractices(
        ofArtist: (state as PracticeListLoaded).ofArtist,
        ofDance: (state as PracticeListLoaded).ofDance,
        ofFigure: (state as PracticeListLoaded).ofFigure,
        ofVideo: (state as PracticeListLoaded).ofVideo,
        offset: 0,
      );

      emit(PracticeListLoaded(
        practices: practiceViewModels,
        hasReachedMax: false,
      ));
    }
  }

  Future<List<PracticeViewModel>> _fetchPractices({
    String? ofArtist,
    String? ofDance,
    String? ofFigure,
    String? ofVideo,
    required int offset,
    int limit = 10,
  }) async {
    List<PracticeEntity> practiceEntities;
    if (ofFigure != null) {
      practiceEntities = await practiceRepository.getPracticesOfFigure(
        ofFigure,
        offset: Offset(
          offset: offset,
          limit: limit,
        ),
      );
    } else {
      practiceEntities = await practiceRepository.getList(
        offset: Offset(
          offset: offset,
          limit: limit,
        ),
      );
    }

    List<PracticeViewModel> practiceViewModels = practiceEntities
        .map<PracticeViewModel>(
            (practiceEntity) => mapper.toPracticeViewModel(practiceEntity))
        .toList();
    return practiceViewModels;
  }
}
