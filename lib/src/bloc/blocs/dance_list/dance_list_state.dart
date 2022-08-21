import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:equatable/equatable.dart';

enum DanceListStatus { initial, loading, refreshing, success, failure }

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
  final List<String> selectedDances;
  final Error? error;

  const DanceListState({
    this.status = DanceListStatus.initial,
    this.ofSearch,
    this.ofArtist,
    this.ofVideo,
    this.dances = const <DanceViewModel>[],
    this.hasReachedMax = false,
    this.selectedDances = const <String>[],
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
    String? ofSearch,
    String? ofArtist,
    String? ofVideo,
    List<DanceViewModel>? dances,
    bool? hasReachedMax,
    List<String>? selectedDances,
    Error? error,
  }) {
    return DanceListState(
      status: status ?? this.status,
      ofSearch: ofSearch ?? this.ofSearch,
      ofArtist: ofArtist ?? this.ofArtist,
      ofVideo: ofVideo ?? this.ofVideo,
      dances: dances ?? this.dances,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      selectedDances: selectedDances ?? this.selectedDances,
      error: error ?? this.error,
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
