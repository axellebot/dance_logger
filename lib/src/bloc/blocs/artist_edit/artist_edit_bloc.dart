import 'dart:async';

import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiver/core.dart';

class ArtistEditBloc extends Bloc<ArtistEditEvent, ArtistEditState> {
  final ArtistRepository artistRepository;
  final ModelMapper mapper;

  ArtistEditBloc({
    required this.artistRepository,
    required this.mapper,
  }) : super(const ArtistEditState()) {
    on<ArtistEditStart>(_onArtistEditStart);
    on<ArtistEditChangeName>(_onArtistEditChangeName);
    on<ArtistEditChangeImageUrl>(_onArtistEditChangeImageUrl);
    on<ArtistEditSubmit>(_onArtistEditSubmit);
    on<ArtistEditDelete>(_onArtistEditDelete);
  }

  FutureOr<void> _onArtistEditStart(
    ArtistEditStart event,
    Emitter<ArtistEditState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onArtistEditStart');

    try {
      emit(state.copyWith(
        status: ArtistEditStatus.loading,
        ofId: Optional.fromNullable(event.artistId),
      ));

      ArtistViewModel? artistViewModel;
      if (event.artistId != null) {
        ArtistEntity artistEntity =
            await artistRepository.getById(event.artistId!);
        artistViewModel = mapper.toArtistViewModel(artistEntity);
      }

      emit(state.copyWith(
        status: ArtistEditStatus.ready,
        ofId: Optional.fromNullable(event.artistId),
        initialArtist: Optional.fromNullable(artistViewModel),
        error: const Optional.absent(),
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: ArtistEditStatus.failure,
        ofId: Optional.fromNullable(event.artistId),
        error: Optional.of(error),
      ));
    }
  }

  FutureOr<void> _onArtistEditChangeName(
    ArtistEditChangeName event,
    Emitter<ArtistEditState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onArtistEditChangeName');

    emit(state.copyWith(
      artistName: Optional.of(event.artistName),
    ));
  }

  FutureOr<void> _onArtistEditChangeImageUrl(
    ArtistEditChangeImageUrl event,
    Emitter<ArtistEditState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onArtistEditChangeImageUrl');

    String? imageUrl;
    if (event.artistImageUrl != null) {
      imageUrl = event.artistImageUrl!.isNotEmpty ? event.artistImageUrl : null;
    }

    emit(state.copyWith(
      artistImageUrl: Optional.fromNullable(imageUrl),
    ));
  }

  FutureOr<void> _onArtistEditSubmit(
    ArtistEditSubmit event,
    Emitter<ArtistEditState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onArtistEditSubmit');

    try {
      emit(state.copyWith(
        status: ArtistEditStatus.loading,
      ));
      ArtistViewModel artistViewModel;

      if (state.initialArtist != null) {
        artistViewModel = state.initialArtist!.copyWith(
          name: state.artistName,
          imageUrl: state.artistImageUrl,
        );
        artistViewModel.incrementVersion();
      } else {
        artistViewModel = ArtistViewModel.createNew(
          name: state.artistName!,
          imageUrl: state.artistImageUrl?.orNull,
        );
      }

      ArtistEntity artistEntity =
          await artistRepository.save(mapper.toArtistEntity(artistViewModel));
      artistViewModel = mapper.toArtistViewModel(artistEntity);

      emit(ArtistEditState(
        status: ArtistEditStatus.editSuccess,
        ofId: artistViewModel.id,
        initialArtist: artistViewModel,
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: ArtistEditStatus.failure,
        error: Optional.of(error),
      ));
    }
  }

  FutureOr<void> _onArtistEditDelete(
    ArtistEditDelete event,
    Emitter<ArtistEditState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onArtistEditDelete');

    if (state.initialArtist == null) return;
    try {
      emit(state.copyWith(
        status: ArtistEditStatus.loading,
      ));

      await artistRepository.deleteById(state.initialArtist!.id);

      emit(const ArtistEditState(
        status: ArtistEditStatus.deleteSuccess,
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: ArtistEditStatus.failure,
        error: Optional.of(error),
      ));
    }
  }
}
