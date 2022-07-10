import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FigureBloc extends Bloc<FigureEvent, FigureState> {
  final ArtistRepository artistRepository;
  final FigureRepository figureRepository;
  final PracticeRepository practiceRepository;
  final TimeRepository timeRepository;
  final VideoRepository videoRepository;
  final ModelMapper mapper;

  FigureBloc({
    required this.artistRepository,
    required this.figureRepository,
    required this.practiceRepository,
    required this.timeRepository,
    required this.videoRepository,
    required this.mapper,
  }) : super(const FigureUninitialized()) {
    on<FigureLoad>((event, emit) async {
      emit(const FigureLoading());

      FigureEntity figureDataModel =
          await figureRepository.getById(event.figureId);
      FigureViewModel figureViewModel =
          mapper.toFigureViewModel(figureDataModel);

      emit(FigureLoaded(figure: figureViewModel));
    });
  }
}
