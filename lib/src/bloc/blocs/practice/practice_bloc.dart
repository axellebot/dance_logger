import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PracticeBloc extends Bloc<PracticeEvent, PracticeState> {
  final PracticeRepository practiceRepository;
  final FigureRepository figureRepository;
  final VideoRepository videoRepository;
  final ModelMapper mapper;

  PracticeBloc({
    required this.practiceRepository,
    required this.figureRepository,
    required this.videoRepository,
    required this.mapper,
  }) : super(const PracticeUninitialized()) {
    on<PracticeLoad>((event, emit) async {
      emit(const PracticeLoading());

      PracticeEntity practiceDataModel =
          await practiceRepository.getById(event.practiceId);
      PracticeViewModel practiceViewModel =
          mapper.toPracticeViewModel(practiceDataModel);

      emit(PracticeLoaded(practice: practiceViewModel));
    });
  }
}
