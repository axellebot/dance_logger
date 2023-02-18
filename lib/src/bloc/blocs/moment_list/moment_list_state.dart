import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:equatable/equatable.dart';

enum MomentListStatus {
  initial,
  loading,
  loadingSuccess,
  loadingFailure,
  refreshing,
  refreshingSuccess,
  refreshingFailure,
  deleteSuccess,
  deleteFailure,
}

class MomentListState extends Equatable implements MomentListParams {
  final MomentListStatus status;

  @override
  final String? ofArtistId;
  @override
  final String? ofFigureId;
  @override
  final String? ofVideoId;

  final List<MomentViewModel> moments;
  final bool hasReachedMax;
  final List<MomentViewModel> selectedMoments;
  final Error? error;

  const MomentListState({
    this.status = MomentListStatus.initial,
    this.ofArtistId,
    this.ofFigureId,
    this.ofVideoId,
    this.moments = const <MomentViewModel>[],
    this.hasReachedMax = false,
    this.selectedMoments = const <MomentViewModel>[],
    this.error,
  });

  @override
  List<Object?> get props => [
        status,
        ofArtistId,
        ofFigureId,
        ofVideoId,
        moments,
        hasReachedMax,
        selectedMoments,
        error,
      ];

  MomentListState copyWith({
    MomentListStatus? status,
    String? ofArtistId,
    String? ofFigureId,
    String? ofVideoId,
    List<MomentViewModel>? moments,
    bool? hasReachedMax,
    List<MomentViewModel>? selectedMoments,
    Error? error,
  }) {
    return MomentListState(
      status: status ?? this.status,
      ofArtistId: ofArtistId ?? this.ofArtistId,
      ofFigureId: ofFigureId ?? this.ofFigureId,
      ofVideoId: ofVideoId ?? this.ofVideoId,
      moments: moments ?? this.moments,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      selectedMoments: selectedMoments ?? this.selectedMoments,
      error: error ?? this.error,
    );
  }

  @override
  String toString() => 'MomentListState{'
      'status: $status, '
      'ofArtistId: $ofArtistId, '
      'ofFigureId: $ofFigureId, '
      'ofVideoId: $ofVideoId, '
      'moments: $moments, '
      'hasReachedMax: $hasReachedMax, '
      'selectedMoments: $selectedMoments, '
      'error: $error'
      '}';
}
