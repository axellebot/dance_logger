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
    on<FigureDetailRefresh>(_onFigureDetailRefresh);
    on<FigureDetailDelete>(_onFigureDelete);
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
        status: FigureDetailStatus.detailSuccess,
        ofId: figureViewModel.id,
        figure: figureViewModel,
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: FigureDetailStatus.failure,
        ofId: event.figureId,
        error: error,
      ));
    }
  }

  FutureOr<void> _onFigureDetailRefresh(
    FigureDetailRefresh event,
    Emitter<FigureDetailState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onFigureDetailRefresh');

    try {
      emit(state.copyWith(
        status: FigureDetailStatus.refreshing,
      ));

      FigureEntity figureDataModel =
          await figureRepository.getById(state.ofId!);
      FigureViewModel figureViewModel =
          mapper.toFigureViewModel(figureDataModel);

      emit(state.copyWith(
        status: FigureDetailStatus.detailSuccess,
        ofId: figureViewModel.id,
        figure: figureViewModel,
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: FigureDetailStatus.failure,
        error: error,
      ));
    }
  }

  FutureOr<void> _onFigureDelete(
    FigureDetailDelete event,
    Emitter<FigureDetailState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onFigureDelete');

    if (state.figure == null) return;
    try {
      emit(state.copyWith(
        status: FigureDetailStatus.loading,
      ));

      await figureRepository.deleteById(state.figure!.id);

      emit(const FigureDetailState(
        status: FigureDetailStatus.deleteSuccess,
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: FigureDetailStatus.failure,
        error: error,
      ));
    }
  }
}
