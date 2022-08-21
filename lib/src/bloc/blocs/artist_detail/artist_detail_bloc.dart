import 'dart:async';

import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArtistDetailBloc extends Bloc<ArtistDetailEvent, ArtistDetailState> {
  final ArtistRepository artistRepository;
  final ModelMapper mapper;

  ArtistDetailBloc({
    required this.artistRepository,
    required this.mapper,
  }) : super(const ArtistDetailState()) {
    on<ArtistDetailLoad>(_onArtistLoad);
    on<ArtistDetailRefresh>(_onArtistDetailRefresh);
    on<ArtistDetailDelete>(_onArtistDelete);
  }

  FutureOr<void> _onArtistLoad(
    ArtistDetailLoad event,
    Emitter<ArtistDetailState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onArtistLoad');

    try {
      emit(state.copyWith(
        status: ArtistDetailStatus.loading,
      ));

      ArtistEntity artistDataModel =
          await artistRepository.getById(event.artistId);
      ArtistViewModel artistViewModel =
          mapper.toArtistViewModel(artistDataModel);

      emit(state.copyWith(
        status: ArtistDetailStatus.detailSuccess,
        ofId: artistViewModel.id,
        artist: artistViewModel,
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: ArtistDetailStatus.failure,
        ofId: event.artistId,
        error: error,
      ));
    }
  }

  FutureOr<void> _onArtistDetailRefresh(
    ArtistDetailRefresh event,
    Emitter<ArtistDetailState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onArtistDetailRefresh');

    try {
      emit(state.copyWith(
        status: ArtistDetailStatus.refreshing,
      ));

      ArtistEntity artistDataModel =
          await artistRepository.getById(state.ofId!);
      ArtistViewModel artistViewModel =
          mapper.toArtistViewModel(artistDataModel);

      emit(state.copyWith(
        status: ArtistDetailStatus.detailSuccess,
        ofId: artistViewModel.id,
        artist: artistViewModel,
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: ArtistDetailStatus.failure,
        error: error,
      ));
    }
  }

  FutureOr<void> _onArtistDelete(
    ArtistDetailDelete event,
    Emitter<ArtistDetailState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onDanceDeleted');

    if (state.artist == null) return;
    try {
      emit(state.copyWith(
        status: ArtistDetailStatus.loading,
      ));

      await artistRepository.deleteById(state.artist!.id);

      emit(const ArtistDetailState(
        status: ArtistDetailStatus.deleteSuccess,
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: ArtistDetailStatus.failure,
        error: error,
      ));
    }
  }
}
