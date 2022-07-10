import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  final VideoRepository videoRepository;
  final ModelMapper mapper;

  VideoBloc({
    required this.videoRepository,
    required this.mapper,
  }) : super(const VideoUninitialized()) {
    on<VideoLoad>((event, emit) async {
      emit(const VideoLoading());

      VideoEntity videoDataModel = await videoRepository.getById(event.videoId);
      VideoViewModel videoViewModel = mapper.toVideoViewModel(videoDataModel);

      emit(VideoLoaded(video: videoViewModel));
    });
  }
}
