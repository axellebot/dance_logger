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
  final String? ofArtist;
  @override
  final String? ofVideo;

  final List<DanceViewModel> dances;
  final bool hasReachedMax;
  final List<DanceViewModel> selectedDances;
  final Error? error;

  const DanceListState({
    this.status = DanceListStatus.initial,
    this.ofSearch,
    this.ofArtist,
    this.ofVideo,
    this.dances = const <DanceViewModel>[],
    this.hasReachedMax = false,
    this.selectedDances = const <DanceViewModel>[],
    this.error,
  }) : assert(ofSearch == null || (ofArtist == null && ofVideo == null));

  @override
  List<Object?> get props => [
        status,
        ofSearch,
        ofArtist,
        dances,
        hasReachedMax,
        selectedDances,
        error,
      ];

  DanceListState copyWith({
    DanceListStatus? status,
    Optional<String>? ofSearch,
    Optional<String>? ofArtist,
    Optional<String>? ofVideo,
    List<DanceViewModel>? dances,
    bool? hasReachedMax,
    List<DanceViewModel>? selectedDances,
    Optional<Error>? error,
  }) {
    return DanceListState(
      status: status ?? this.status,
      ofSearch: ofSearch != null ? ofSearch.orNull : this.ofSearch,
      ofArtist: ofArtist != null ? ofArtist.orNull : this.ofArtist,
      ofVideo: ofVideo != null ? ofVideo.orNull : this.ofVideo,
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
      'ofArtist: $ofArtist, '
      'ofVideo: $ofVideo, '
      'dances: $dances, '
      'hasReachedMax: $hasReachedMax, '
      'selectedDances: $selectedDances, '
      'error: $error'
      '}';
}
