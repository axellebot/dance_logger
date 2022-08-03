import 'dart:async';

import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArtistBloc extends Bloc<ArtistEvent, ArtistDetailState> {
  final ArtistRepository artistRepository;
  final ModelMapper mapper;

  ArtistBloc({
    required this.artistRepository,
    required this.mapper,
  }) : super(const ArtistDetailState()) {
    on<ArtistLoad>(_onArtistLoad);
  }

  FutureOr<void> _onArtistLoad(event, emit) async {
    emit(state.copyWith(
      status: ArtistDetailStatus.loading,
    ));

    ArtistEntity artistDataModel =
        await artistRepository.getById(event.artistId);
    ArtistViewModel artistViewModel = mapper.toArtistViewModel(artistDataModel);

    emit(state.copyWith(
      status: ArtistDetailStatus.success,
      artist: artistViewModel,
    ));
  }
}
