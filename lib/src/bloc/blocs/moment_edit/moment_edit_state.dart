import 'package:dance/presentation.dart';
import 'package:equatable/equatable.dart';
import 'package:quiver/core.dart';

enum MomentEditStatus {
  initial,
  loading,
  ready,
  editSuccess,
  deleteSuccess,
  failure
}

class MomentEditState extends Equatable {
  final MomentEditStatus status;
  final String? ofId;
  final MomentViewModel? initialMoment;
  final Duration? startTime;
  final Duration? endTime;
  final FigureViewModel? initialFigure;
  final FigureViewModel? figure;
  final VideoViewModel? initialVideo;
  final VideoViewModel? video;
  final List<ArtistViewModel> initialArtists;
  final List<ArtistViewModel> artists;
  final Error? error;

  const MomentEditState({
    this.status = MomentEditStatus.initial,
    this.ofId,
    this.initialMoment,
    this.startTime,
    this.endTime,
    this.initialFigure,
    this.figure,
    this.initialVideo,
    this.video,
    this.initialArtists = const <ArtistViewModel>[],
    this.artists = const <ArtistViewModel>[],
    this.error,
  }) : super();

  @override
  List<Object?> get props => [
        status,
        ofId,
        initialMoment,
        startTime,
        endTime,
        initialFigure,
        figure,
        initialVideo,
        video,
        initialArtists,
        artists,
        error,
      ];

  MomentEditState copyWith({
    MomentEditStatus? status,
    Optional<String>? ofId,
    Optional<MomentViewModel>? initialMoment,
    Optional<Duration>? startTime,
    Optional<Duration>? endTime,
    Optional<FigureViewModel>? initialFigure,
    Optional<FigureViewModel>? figure,
    Optional<VideoViewModel>? initialVideo,
    Optional<VideoViewModel>? video,
    List<ArtistViewModel>? initialArtists,
    List<ArtistViewModel>? artists,
    Optional<Error>? error,
  }) {
    return MomentEditState(
      status: status ?? this.status,
      ofId: ofId?.orNull ?? this.ofId,
      initialMoment: initialMoment?.orNull ?? this.initialMoment,
      startTime: startTime?.orNull ?? this.startTime,
      endTime: endTime?.orNull ?? this.endTime,
      initialFigure: initialFigure?.orNull ?? this.initialFigure,
      figure: figure?.orNull ?? this.figure,
      initialVideo: initialVideo?.orNull ?? this.initialVideo,
      video: video?.orNull ?? this.video,
      initialArtists: initialArtists ?? this.initialArtists,
      artists: artists ?? this.artists,
      error: error?.orNull ?? this.error,
    );
  }

  @override
  String toString() => 'MomentEditLoaded{'
      'status: $status, '
      'initialMoment: $initialMoment, '
      'startTime: $startTime, '
      'endTime: $endTime, '
      'initialFigure: $initialFigure, '
      'figure: $figure, '
      'initialVideo: $initialVideo, '
      'video: $video, '
      'initialArtists: $initialArtists, '
      'artists: $artists, '
      'error: $error'
      '}';
}
