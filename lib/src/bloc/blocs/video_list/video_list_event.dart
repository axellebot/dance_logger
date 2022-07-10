import 'package:dance/bloc.dart';
import 'package:equatable/equatable.dart';

import 'video_list_params.dart';

/// [VideoListEvent] that must be dispatch to [VideoListBloc]
abstract class VideoListEvent extends Equatable {
  const VideoListEvent();

  @override
  String toString() => 'VideoListEvent{}';
}

class VideoListLoad extends VideoListEvent implements VideoListParams {
  @override
  final String? ofArtist;
  @override
  final String? ofDance;
  @override
  final String? ofFigure;

  const VideoListLoad({
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
