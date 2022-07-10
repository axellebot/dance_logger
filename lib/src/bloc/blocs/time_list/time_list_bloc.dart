import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimeListBloc extends Bloc<TimeListEvent, TimeListState> {
  final TimeRepository timeRepository;
  final ModelMapper mapper;

  TimeListBloc({
    required this.timeRepository,
    required this.mapper,
  }) : super(const TimeListUninitialized()) {
    on<TimeListLoad>((event, emit) async {
      if (state is TimeListUninitialized) {
        final List<TimeViewModel> timeViewModels;
        timeViewModels = await _fetchTimes(
          ofArtist: event.ofArtist,
          ofFigure: event.ofFigure,
          ofVideo: event.ofVideo,
          offset: 0,
        );
        emit(TimeListLoaded(
          ofArtist: event.ofArtist,
          ofFigure: event.ofFigure,
          ofVideo: event.ofVideo,
          times: timeViewModels,
          hasReachedMax: false,
        ));
      }
    });
    on<TimeListLoadMore>((event, emit) async {
      if (state is TimeListLoaded) {
        final List<TimeViewModel> timeViewModels;
        timeViewModels = await _fetchTimes(
          ofArtist: (state as TimeListLoaded).ofArtist,
          ofFigure: (state as TimeListLoaded).ofFigure,
          ofVideo: (state as TimeListLoaded).ofVideo,
          offset: (state as TimeListLoaded).times.length,
        );
        if (timeViewModels.isNotEmpty) {
          emit((state as TimeListLoaded).copyWith(
            times: (state as TimeListLoaded).times + timeViewModels,
            hasReachedMax: false,
          ));
        } else {
          emit((state as TimeListLoaded).copyWith(
            hasReachedMax: true,
          ));
        }
      }
    });

    on<TimeListRefresh>((event, emit) async {
      if (state is TimeListLoaded) {
        List<TimeViewModel> timeViewModels = await _fetchTimes(
          ofArtist: (state as TimeListLoaded).ofArtist,
          ofFigure: (state as TimeListLoaded).ofFigure,
          ofVideo: (state as TimeListLoaded).ofVideo,
          offset: 0,
        );

        emit((state as TimeListLoaded).copyWith(
          times: timeViewModels,
          hasReachedMax: false,
        ));
      }
    });
  }

  Future<List<TimeViewModel>> _fetchTimes({
    String? ofArtist,
    String? ofFigure,
    String? ofVideo,
    required int offset,
    int limit = 10,
  }) async {
    List<TimeEntity> timeEntities;

    if (ofArtist != null) {
      timeEntities = await timeRepository.getTimesOfArtist(
        ofArtist,
        offset: Offset(
          offset: offset,
          limit: limit,
        ),
      );
    } else if (ofFigure != null) {
      timeEntities = await timeRepository.getTimesOfFigure(
        ofFigure,
        offset: Offset(
          offset: offset,
          limit: limit,
        ),
      );
    } else if (ofVideo != null) {
      timeEntities = await timeRepository.getTimesOfVideo(
        ofVideo,
        offset: Offset(
          offset: offset,
          limit: limit,
        ),
      );
    } else {
      timeEntities = await timeRepository.getList(
        offset: Offset(
          offset: offset,
          limit: limit,
        ),
      );
    }

    List<TimeViewModel> timeViewModels = timeEntities
        .map<TimeViewModel>((timeEntity) => mapper.toTimeViewModel(timeEntity))
        .toList();
    return timeViewModels;
  }
}
