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
  final String? ofArtist;
  @override
  final String? ofDance;
  @override
  final String? ofVideo;

  final List<FigureViewModel> figures;
  final bool hasReachedMax;
  final List<FigureViewModel> selectedFigures;
  final Error? error;

  const FigureListState({
    this.status = FigureListStatus.initial,
    this.ofArtist,
    this.ofDance,
    this.ofVideo,
    this.figures = const <FigureViewModel>[],
    this.hasReachedMax = false,
    this.selectedFigures = const <FigureViewModel>[],
    this.error,
  });

  @override
  List<Object?> get props => [
        status,
        ofArtist,
        ofDance,
        ofVideo,
        figures,
        hasReachedMax,
        selectedFigures,
        error,
      ];

  FigureListState copyWith({
    FigureListStatus? status,
    String? ofArtist,
    String? ofDance,
    String? ofVideo,
    List<FigureViewModel>? figures,
    bool? hasReachedMax,
    List<FigureViewModel>? selectedFigures,
    Error? error,
  }) {
    return FigureListState(
      status: status ?? this.status,
      ofArtist: ofArtist ?? this.ofArtist,
      ofDance: ofDance ?? this.ofDance,
      ofVideo: ofVideo ?? this.ofVideo,
      figures: figures ?? this.figures,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      selectedFigures: selectedFigures ?? this.selectedFigures,
      error: error ?? this.error,
    );
  }

  @override
  String toString() => 'FigureListState{'
      'status: $status, '
      'ofArtist: $ofArtist, '
      'ofDance: $ofDance, '
      'ofVideo: $ofVideo, '
      'figures: $figures, '
      'hasReachedMax: $hasReachedMax, '
      'selectedFigures: $selectedFigures, '
      'error: $error'
      '}';
}
