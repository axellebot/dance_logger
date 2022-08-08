import 'dart:async';

import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DanceDetailBloc extends Bloc<DanceDetailEvent, DanceDetailState> {
  final DanceRepository danceRepository;
  final ModelMapper mapper;

  DanceDetailBloc({
    required this.danceRepository,
    required this.mapper,
  }) : super(const DanceDetailState()) {
    on<DanceDetailLoad>(_onDanceDetailLoad);
  }

  FutureOr<void> _onDanceDetailLoad(event, emit) async {
    try {
      emit(state.copyWith(
        status: DanceDetailStatus.loading,
      ));

      DanceEntity danceDataModel = await danceRepository.getById(event.danceId);
      DanceViewModel danceViewModel = mapper.toDanceViewModel(danceDataModel);

      emit(state.copyWith(
        status: DanceDetailStatus.success,
        dance: danceViewModel,
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: DanceDetailStatus.failure,
        error: error,
      ));
    }
  }
}
