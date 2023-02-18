import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:equatable/equatable.dart';

enum PracticeListStatus {
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

class PracticeListState extends Equatable implements PracticeListParams {
  final PracticeListStatus status;

  @override
  final String? ofArtistId;
  @override
  final String? ofDanceId;
  @override
  final String? ofFigureId;
  @override
  final String? ofVideoId;

  final List<PracticeViewModel> practices;
  final bool hasReachedMax;
  final List<PracticeViewModel> selectedPractices;
  final Error? error;

  const PracticeListState({
    this.status = PracticeListStatus.initial,
    this.ofArtistId,
    this.ofDanceId,
    this.ofFigureId,
    this.ofVideoId,
    this.practices = const <PracticeViewModel>[],
    this.hasReachedMax = false,
    this.selectedPractices = const <PracticeViewModel>[],
    this.error,
  });

  @override
  List<Object?> get props => [
        status,
        ofArtistId,
        ofDanceId,
        ofFigureId,
        ofVideoId,
        practices,
        hasReachedMax,
        selectedPractices,
        error,
      ];

  PracticeListState copyWith({
    PracticeListStatus? status,
    String? ofArtist,
    String? ofDanceId,
    String? ofFigureId,
    String? ofVideoId,
    List<PracticeViewModel>? practices,
    bool? hasReachedMax,
    List<PracticeViewModel>? selectedPractices,
    Error? error,
  }) {
    return PracticeListState(
      status: status ?? this.status,
      ofArtistId: ofArtist ?? this.ofArtistId,
      ofDanceId: ofDanceId ?? this.ofDanceId,
      ofFigureId: ofFigureId ?? this.ofFigureId,
      ofVideoId: ofVideoId ?? this.ofVideoId,
      practices: practices ?? this.practices,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      selectedPractices: selectedPractices ?? this.selectedPractices,
      error: error ?? this.error,
    );
  }

  @override
  String toString() => 'PracticeListState{'
      'status: $status, '
      'ofArtist: $ofArtistId, '
      'ofDanceId: $ofDanceId, '
      'ofFigureId: $ofFigureId, '
      'ofVideoId: $ofVideoId, '
      'practices: $practices, '
      'hasReachedMax: $hasReachedMax, '
      'selectedPractices: $selectedPractices, '
      'error: $error'
      '}';
}
