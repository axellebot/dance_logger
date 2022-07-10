import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArtistBloc extends Bloc<ArtistEvent, ArtistState> {
  final ArtistRepository artistRepository;
  final ModelMapper mapper;

  ArtistBloc({
    required this.artistRepository,
    required this.mapper,
  }) : super(const ArtistUninitialized()) {
    on<ArtistLoad>((event, emit) async {
      emit(const ArtistLoading());

      ArtistEntity artistDataModel =
          await artistRepository.getById(event.artistId);
      ArtistViewModel artistViewModel =
          mapper.toArtistViewModel(artistDataModel);

      emit(ArtistLoaded(artist: artistViewModel));
    });
  }
}
