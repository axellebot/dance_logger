import 'dart:async';

import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PracticeDetailBloc
    extends Bloc<PracticeDetailEvent, PracticeDetailState> {
  final PracticeRepository practiceRepository;
  final ModelMapper mapper;

  PracticeDetailBloc({
    required this.practiceRepository,
    required this.mapper,
  }) : super(const PracticeDetailState()) {
    on<PracticeDetailLoad>(_onPracticeDetailLoad);
  }

  FutureOr<void> _onPracticeDetailLoad(
    PracticeDetailLoad event,
    Emitter<PracticeDetailState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onPracticeDetailLoad');
    try {
      emit(state.copyWith(
        status: PracticeDetailStatus.loading,
      ));

      PracticeEntity practiceDataModel =
          await practiceRepository.getById(event.practiceId);
      PracticeViewModel practiceViewModel =
          mapper.toPracticeViewModel(practiceDataModel);

      emit(state.copyWith(
        status: PracticeDetailStatus.success,
        practice: practiceViewModel,
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: PracticeDetailStatus.failure,
        error: error,
      ));
    }
  }
}
