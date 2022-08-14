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
  final List<String> selected;
  final Error? error;

  const DanceListState({
    this.status = DanceListStatus.initial,
    this.ofArtist,
    this.dances = const <DanceViewModel>[],
    this.hasReachedMax = false,
    this.selected = const <String>[],
    this.error,
  });

  @override
  List<Object?> get props => [
        status,
        ofArtist,
        dances,
        hasReachedMax,
        selected,
        error,
      ];

  DanceListState copyWith({
    DanceListStatus? status,
    String? ofArtist,
    String? ofFigure,
    String? ofVideo,
    List<DanceViewModel>? dances,
    bool? hasReachedMax,
    List<String>? selected,
    Error? error,
  }) {
    return DanceListState(
      status: status ?? this.status,
      ofArtist: ofArtist ?? this.ofArtist,
      dances: dances ?? this.dances,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      selected: selected ?? this.selected,
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
        'selected: $selected, '
        'error: $error'
        '}';
  }
}
