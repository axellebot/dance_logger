import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:equatable/equatable.dart';

/// [VideoListEvent] that must be dispatch to [VideoListBloc]
abstract class VideoListEvent extends Equatable {
  const VideoListEvent();

  @override
  String toString() => 'VideoListEvent{}';
}

class VideoListLoad extends VideoListEvent implements VideoListParams {
  /// VideoListParams
  @override
  final String? ofSearch;
  @override
  final String? ofArtist;
  @override
  final String? ofDance;
  @override
  final String? ofFigure;

  const VideoListLoad({
    /// VideoListParams
    this.ofSearch,
    this.ofArtist,
    this.ofDance,
    this.ofFigure,
  }) : assert(ofSearch == null ||
            (ofArtist == null && ofDance == null && ofFigure == null));

  @override
  List<Object?> get props => [ofSearch, ofArtist, ofDance, ofFigure];

  @override
  String toString() => 'VideoListLoad{'
      'ofSearch: $ofSearch, '
      'ofArtist: $ofArtist, '
      'ofDance: $ofDance, '
      'ofFigure: $ofFigure'
      '}';
}

class VideoListLoadMore extends VideoListEvent {
  const VideoListLoadMore();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'VideoListLoadMore{}';
}

class VideoListRefresh extends VideoListEvent {
  const VideoListRefresh();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'VideoListRefresh{}';
}

class VideoListSelect extends VideoListEvent {
  final VideoViewModel video;

  const VideoListSelect({
    required this.video,
  });

  @override
  List<Object?> get props => [video];

  @override
  String toString() => 'VideoListSelect{'
      'video: $video'
      '}';
}

class VideoListUnselect extends VideoListEvent {
  final VideoViewModel? video;

  const VideoListUnselect({
    this.video,
  });

  @override
  List<Object?> get props => [video];

  @override
  String toString() => 'VideoListUnselect{'
      'video: $video'
      '}';
}

class VideoListDelete extends VideoListEvent {
  const VideoListDelete();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'VideoListDelete{'
      '}';
}
