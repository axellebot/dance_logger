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
  final String? ofArtistId;
  @override
  final String? ofDanceId;
  @override
  final String? ofFigureId;

  const VideoListLoad({
    /// VideoListParams
    this.ofSearch,
    this.ofArtistId,
    this.ofDanceId,
    this.ofFigureId,
  }) : assert(ofSearch == null ||
            (ofArtistId == null && ofDanceId == null && ofFigureId == null));

  @override
  List<Object?> get props => [ofSearch, ofArtistId, ofDanceId, ofFigureId];

  @override
  String toString() => 'VideoListLoad{'
      'ofSearch: $ofSearch, '
      'ofArtistId: $ofArtistId, '
      'ofDanceId: $ofDanceId, '
      'ofFigureId: $ofFigureId'
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
  final List<VideoViewModel> videos;

  const VideoListSelect({
    required this.videos,
  });

  @override
  List<Object?> get props => [videos];

  @override
  String toString() => 'VideoListSelect{'
      'videos: $videos'
      '}';
}

class VideoListUnselect extends VideoListEvent {
  final List<VideoViewModel>? videos;

  const VideoListUnselect({
    this.videos,
  });

  @override
  List<Object?> get props => [videos];

  @override
  String toString() => 'VideoListUnselect{'
      'videos: $videos'
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
