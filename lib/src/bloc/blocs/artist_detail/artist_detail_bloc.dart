import 'dart:async';

import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiver/core.dart';

class ArtistDetailBloc extends Bloc<ArtistDetailEvent, ArtistDetailState> {
  final ArtistRepository artistRepository;
  final ModelMapper mapper;

  ArtistDetailBloc({
    required this.artistRepository,
    required this.mapper,
  }) : super(const ArtistDetailState()) {
    on<ArtistDetailLoad>(_onArtistDetailLoad);
    on<ArtistDetailRefresh>(_onArtistDetailRefresh);
    on<ArtistDetailDelete>(_onArtistDelete);
  }

  FutureOr<void> _onArtistDetailLoad(
    ArtistDetailLoad event,
    Emitter<ArtistDetailState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onArtistLoad');

    try {
      emit(state.copyWith(
        status: ArtistDetailStatus.refreshing,
        ofId: Optional.of(event.artistId),
      ));

      ArtistEntity artistDataModel =
          await artistRepository.getById(event.artistId);
      ArtistViewModel artistViewModel =
          mapper.toArtistViewModel(artistDataModel);

      emit(state.copyWith(
        status: ArtistDetailStatus.refreshingSuccess,
        ofId: Optional.of(artistViewModel.id),
        artist: Optional.of(artistViewModel),
        error: const Optional.absent(),
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: ArtistDetailStatus.refreshingFailure,
        ofId: Optional.of(event.artistId),
        error: Optional.of(error),
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
        status: ArtistDetailStatus.refreshingSuccess,
        ofId: Optional.of(artistViewModel.id),
        artist: Optional.of(artistViewModel),
        error: const Optional.absent(),
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: ArtistDetailStatus.refreshingFailure,
        error: Optional.of(error),
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
      await artistRepository.deleteById(state.artist!.id);

      emit(const ArtistDetailState(
        status: ArtistDetailStatus.deleteSuccess,
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: ArtistDetailStatus.deleteFailure,
        error: Optional.of(error),
      ));
    }
  }
}
