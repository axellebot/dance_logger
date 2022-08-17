import 'package:dance/domain.dart';
import 'package:equatable/equatable.dart';

/// [VideoListEvent] that must be dispatch to [VideoListBloc]
abstract class VideoListEvent extends Equatable {
  const VideoListEvent();

  @override
  String toString() => 'VideoListEvent{}';
}

class VideoListLoad extends VideoListEvent implements VideoListParams {
  /// VideoList params
  @override
  final String? ofArtist;
  @override
  final String? ofDance;
  @override
  final String? ofFigure;

  const VideoListLoad({
    /// VideoList params
    this.ofArtist,
    this.ofDance,
    this.ofFigure,
  });

  @override
  List<Object?> get props => [ofArtist, ofDance, ofFigure];

  @override
  String toString() {
    return 'VideoListLoad{'
        'ofArtist: $ofArtist, '
        'ofDance: $ofDance, '
        'ofFigure: $ofFigure'
        '}';
  }
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
  final String videoId;

  const VideoListSelect({
    required this.videoId,
  });

  @override
  List<Object?> get props => [videoId];

  @override
  String toString() => 'VideoListSelect{'
      'videoId: $videoId'
      '}';
}

class VideoListUnselect extends VideoListEvent {
  final String? videoId;

  const VideoListUnselect({
    this.videoId,
  });

  @override
  List<Object?> get props => [videoId];

  @override
  String toString() => 'VideoListUnselect{'
      'videoId: $videoId'
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
