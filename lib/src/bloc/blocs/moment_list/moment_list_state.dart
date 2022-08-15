import 'package:dance/presentation.dart';
import 'package:dance/src/bloc/blocs/moment_list/moment_list_params.dart';
import 'package:equatable/equatable.dart';

enum MomentListStatus { initial, loading, refreshing, success, failure }

class MomentListState extends Equatable implements MomentListParams {
  final MomentListStatus status;

  @override
  final String? ofArtist;
  @override
  final String? ofFigure;
  @override
  final String? ofVideo;

  final List<MomentViewModel> moments;
  final bool hasReachedMax;
  final Error? error;

  const MomentListState({
    this.status = MomentListStatus.initial,
    this.ofArtist,
    this.ofFigure,
    this.ofVideo,
    this.moments = const <MomentViewModel>[],
    this.hasReachedMax = false,
    this.error,
  });

  @override
  List<Object?> get props =>
      [status, ofArtist, ofFigure, ofVideo, moments, hasReachedMax, error];

  MomentListState copyWith({
    MomentListStatus? status,
    String? ofArtist,
    String? ofFigure,
    String? ofVideo,
    List<MomentViewModel>? moments,
    bool? hasReachedMax,
    Error? error,
  }) {
    return MomentListState(
      status: status ?? this.status,
      ofArtist: ofArtist ?? this.ofArtist,
      ofFigure: ofFigure ?? this.ofFigure,
      ofVideo: ofVideo ?? this.ofVideo,
      moments: moments ?? this.moments,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      error: error ?? this.error,
    );
  }

  @override
  String toString() {
    return 'MomentListState{'
        'status: $status, '
        'ofArtist: $ofArtist, '
        'ofFigure: $ofFigure, '
        'ofVideo: $ofVideo, '
        'moments: $moments, '
        'hasReachedMax: $hasReachedMax, '
        'error: $error'
        '}';
  }
}
