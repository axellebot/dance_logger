import 'dart:async';

import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiver/core.dart';

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
        status: FigureDetailStatus.refreshing,
        ofId: Optional.of(event.figureId),
      ));

      FigureEntity figureDataModel =
          await figureRepository.getById(event.figureId);
      FigureViewModel figureViewModel =
          mapper.toFigureViewModel(figureDataModel);

      emit(state.copyWith(
        status: FigureDetailStatus.refreshingSuccess,
        ofId: Optional.of(figureViewModel.id),
        figure: Optional.of(figureViewModel),
        error: const Optional.absent(),
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: FigureDetailStatus.refreshingFailure,
        ofId: Optional.of(event.figureId),
        error: Optional.of(error),
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
        status: FigureDetailStatus.refreshingSuccess,
        ofId: Optional.of(figureViewModel.id),
        figure: Optional.of(figureViewModel),
        error: const Optional.absent(),
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: FigureDetailStatus.refreshingFailure,
        error: Optional.fromNullable(error),
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
      await figureRepository.deleteById(state.figure!.id);

      emit(const FigureDetailState(
        status: FigureDetailStatus.deleteSuccess,
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: FigureDetailStatus.deleteFailure,
        error: Optional.of(error),
      ));
    }
  }
}
