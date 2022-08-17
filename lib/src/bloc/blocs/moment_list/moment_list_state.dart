import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
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
  final List<String> selectedMoments;
  final Error? error;

  const MomentListState({
    this.status = MomentListStatus.initial,
    this.ofArtist,
    this.ofFigure,
    this.ofVideo,
    this.moments = const <MomentViewModel>[],
    this.hasReachedMax = false,
    this.selectedMoments = const <String>[],
    this.error,
  });

  @override
  List<Object?> get props => [
    status,
    ofArtist,
    ofFigure,
    ofVideo,
    moments,
    hasReachedMax,
    selectedMoments,
    error,
  ];

  MomentListState copyWith({
    MomentListStatus? status,
    String? ofArtist,
    String? ofFigure,
    String? ofVideo,
    List<MomentViewModel>? moments,
    bool? hasReachedMax,
    List<String>? selectedMoments,
    Error? error,
  }) {
    return MomentListState(
      status: status ?? this.status,
      ofArtist: ofArtist ?? this.ofArtist,
      ofFigure: ofFigure ?? this.ofFigure,
      ofVideo: ofVideo ?? this.ofVideo,
      moments: moments ?? this.moments,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      selectedMoments: selectedMoments ?? this.selectedMoments,
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
        'selectedMoments: $selectedMoments, '
        'error: $error'
        '}';
  }
}
