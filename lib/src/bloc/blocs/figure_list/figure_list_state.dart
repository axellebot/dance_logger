import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:equatable/equatable.dart';

enum FigureListStatus {
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

class FigureListState extends Equatable implements FigureListParams {
  final FigureListStatus status;

  @override
  final String? ofArtistId;
  @override
  final String? ofDanceId;
  @override
  final String? ofVideoId;

  final List<FigureViewModel> figures;
  final bool hasReachedMax;
  final List<FigureViewModel> selectedFigures;
  final Error? error;

  const FigureListState({
    this.status = FigureListStatus.initial,
    this.ofArtistId,
    this.ofDanceId,
    this.ofVideoId,
    this.figures = const <FigureViewModel>[],
    this.hasReachedMax = false,
    this.selectedFigures = const <FigureViewModel>[],
    this.error,
  });

  @override
  List<Object?> get props => [
        status,
        ofArtistId,
        ofDanceId,
        ofVideoId,
        figures,
        hasReachedMax,
        selectedFigures,
        error,
      ];

  FigureListState copyWith({
    FigureListStatus? status,
    String? ofArtistId,
    String? ofDanceId,
    String? ofVideoId,
    List<FigureViewModel>? figures,
    bool? hasReachedMax,
    List<FigureViewModel>? selectedFigures,
    Error? error,
  }) {
    return FigureListState(
      status: status ?? this.status,
      ofArtistId: ofArtistId ?? this.ofArtistId,
      ofDanceId: ofDanceId ?? this.ofDanceId,
      ofVideoId: ofVideoId ?? this.ofVideoId,
      figures: figures ?? this.figures,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      selectedFigures: selectedFigures ?? this.selectedFigures,
      error: error ?? this.error,
    );
  }

  @override
  String toString() => 'FigureListState{'
      'status: $status, '
      'ofArtistId: $ofArtistId, '
      'ofDanceId: $ofDanceId, '
      'ofVideoId: $ofVideoId, '
      'figures: $figures, '
      'hasReachedMax: $hasReachedMax, '
      'selectedFigures: $selectedFigures, '
      'error: $error'
      '}';
}
