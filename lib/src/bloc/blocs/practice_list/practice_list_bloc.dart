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
    on<PracticeListLoadMore>((event, emit) async {
      List<PracticeViewModel> practiceViewModels = await _fetchPractices(
        offset: (state is PracticeListLoaded)
            ? (state as PracticeListLoaded).practices.length
            : 0,
      );

      emit(PracticeListLoaded(
        practices: (state is PracticeListLoaded)
            ? (state as PracticeListLoaded).practices + practiceViewModels
            : practiceViewModels,
        hasReachedMax: practiceViewModels.isEmpty,
      ));
    });

    on<PracticeListRefresh>((event, emit) async {
      List<PracticeViewModel> practiceViewModels = await _fetchPractices(
        offset: 0,
      );

      emit(PracticeListLoaded(
        practices: practiceViewModels,
        hasReachedMax: false,
      ));
    });
  }

  Future<List<PracticeViewModel>> _fetchPractices({
    required int offset,
    int limit = 10,
  }) async {
    List<PracticeEntity> practiceEntities = await practiceRepository.getList(
      offset: Offset(
        offset: offset,
        limit: limit,
      ),
    );

    List<PracticeViewModel> practiceViewModels = practiceEntities
        .map<PracticeViewModel>(
            (practiceEntity) => mapper.toPracticeViewModel(practiceEntity))
        .toList();
    return practiceViewModels;
  }
}
