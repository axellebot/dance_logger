import 'package:dance/presentation.dart';
import 'package:equatable/equatable.dart';

import 'dance_list_params.dart';

enum DanceListStatus { initial, loading, refreshing, success, failure }

class DanceListState extends Equatable implements DanceListParams {
  final DanceListStatus status;

  @override
  final String? ofArtist;

  final List<DanceViewModel> dances;
  final bool hasReachedMax;
  final Error? error;

  const DanceListState({
    this.status = DanceListStatus.initial,
    this.ofArtist,
    this.dances = const <DanceViewModel>[],
    this.hasReachedMax = false,
    this.error,
  });

  @override
  List<Object?> get props => [status, ofArtist, dances, hasReachedMax, error];

  DanceListState copyWith({
    DanceListStatus? status,
    String? ofArtist,
    String? ofFigure,
    String? ofVideo,
    List<DanceViewModel>? dances,
    bool? hasReachedMax,
    Error? error,
  }) {
    return DanceListState(
      status: status ?? this.status,
      ofArtist: ofArtist ?? this.ofArtist,
      dances: dances ?? this.dances,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      error: error ?? this.error,
    );
  }

  @override
  String toString() {
    return 'DanceListState{'
        'status: $status, '
        'ofArtist: $ofArtist, '
        'dances: $dances, '
        'hasReachedMax: $hasReachedMax, '
        'error: $error'
        '}';
  }
}
