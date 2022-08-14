import 'dart:async';

import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FigureDetailBloc extends Bloc<FigureDetailEvent, FigureDetailState> {
  final FigureRepository figureRepository;
  final ModelMapper mapper;

  FigureDetailBloc({
    required this.figureRepository,
    required this.mapper,
  }) : super(const FigureDetailState()) {
    on<FigureDetailLoad>(_onFigureDetailLoad);
  }

  FutureOr<void> _onFigureDetailLoad(
    FigureDetailLoad event,
    Emitter<FigureDetailState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onFigureDetailLoad');
    try {
      emit(state.copyWith(
        status: FigureDetailStatus.loading,
      ));

      FigureEntity figureDataModel =
          await figureRepository.getById(event.figureId);
      FigureViewModel figureViewModel =
          mapper.toFigureViewModel(figureDataModel);

      emit(state.copyWith(
        status: FigureDetailStatus.success,
        figure: figureViewModel,
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: FigureDetailStatus.failure,
        error: error,
      ));
    }
  }
}
