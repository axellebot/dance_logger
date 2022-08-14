import 'package:equatable/equatable.dart';

import 'dance_list_params.dart';

/// [DanceListEvent] that must be dispatch to [DanceListBloc]
abstract class DanceListEvent extends Equatable {
  const DanceListEvent();

  @override
  String toString() => 'DanceListEvent{}';
}

class DanceListLoad extends DanceListEvent implements DanceListParams {
  @override
  final String? ofArtist;
  @override
  final String? ofFigure;
  @override
  final String? ofVideo;

  const DanceListLoad({
    this.ofArtist,
    this.ofFigure,
    this.ofVideo,
  });

  @override
  List<Object?> get props => [ofArtist, ofFigure, ofVideo];

  @override
  String toString() {
    return 'DanceListLoad{'
        'ofArtist: $ofArtist, '
        'ofFigure: $ofFigure, '
        'ofVideo: $ofVideo'
        '}';
  }
}

class DanceListLoadMore extends DanceListEvent {
  const DanceListLoadMore();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'DanceListLoadMore{}';
}

class DanceListRefresh extends DanceListEvent {
  const DanceListRefresh();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'DanceListRefresh{}';
}

class DanceListToggleSelection extends DanceListEvent {
  final bool selectionEnabled;

  const DanceListToggleSelection({
    required this.selectionEnabled,
  });

  @override
  List<Object?> get props => [selectionEnabled];

  @override
  String toString() => 'DanceListToggleSelection{'
      'selectionEnabled: $selectionEnabled'
      '}';
}

class DanceListSelect extends DanceListEvent {
  final String danceId;

  const DanceListSelect({
    required this.danceId,
  });

  @override
  List<Object?> get props => [danceId];

  @override
  String toString() => 'DanceListSelect{'
      'selectId: $danceId'
      '}';
}

class DanceListUnselect extends DanceListEvent {
  final String? danceId;

  const DanceListUnselect({
    this.danceId,
  });

  @override
  List<Object?> get props => [danceId];

  @override
  String toString() => 'DanceListUnselect{'
      'danceId: $danceId'
      '}';
}

class DanceListDelete extends DanceListEvent {
  const DanceListDelete();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'DanceListDelete{'
      '}';
}
