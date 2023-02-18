import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:equatable/equatable.dart';
import 'package:quiver/core.dart';

enum DanceListStatus {
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

class DanceListState extends Equatable implements DanceListParams {
  final DanceListStatus status;

  @override
  final String? ofSearch;
  @override
  final String? ofArtistId;
  @override
  final String? ofVideoId;

  final List<DanceViewModel> dances;
  final bool hasReachedMax;
  final List<DanceViewModel> selectedDances;
  final Error? error;

  const DanceListState({
    this.status = DanceListStatus.initial,
    this.ofSearch,
    this.ofArtistId,
    this.ofVideoId,
    this.dances = const <DanceViewModel>[],
    this.hasReachedMax = false,
    this.selectedDances = const <DanceViewModel>[],
    this.error,
  }) : assert(ofSearch == null || (ofArtistId == null && ofVideoId == null));

  @override
  List<Object?> get props => [
        status,
        ofSearch,
        ofArtistId,
        dances,
        hasReachedMax,
        selectedDances,
        error,
      ];

  DanceListState copyWith({
    DanceListStatus? status,
    Optional<String>? ofSearch,
    Optional<String>? ofArtistId,
    Optional<String>? ofVideoId,
    List<DanceViewModel>? dances,
    bool? hasReachedMax,
    List<DanceViewModel>? selectedDances,
    Optional<Error>? error,
  }) {
    return DanceListState(
      status: status ?? this.status,
      ofSearch: ofSearch != null ? ofSearch.orNull : this.ofSearch,
      ofArtistId: ofArtistId != null ? ofArtistId.orNull : this.ofArtistId,
      ofVideoId: ofVideoId != null ? ofVideoId.orNull : this.ofVideoId,
      dances: dances ?? this.dances,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      selectedDances: selectedDances ?? this.selectedDances,
      error: error != null ? error.orNull : this.error,
    );
  }

  @override
  String toString() => 'DanceListState{'
      'status: $status, '
      'ofSearch: $ofSearch, '
      'ofArtist: $ofArtistId, '
      'ofVideo: $ofVideoId, '
      'dances: $dances, '
      'hasReachedMax: $hasReachedMax, '
      'selectedDances: $selectedDances, '
      'error: $error'
      '}';
}
