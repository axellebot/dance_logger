import 'package:equatable/equatable.dart';

import 'practice_list_params.dart';

/// [PracticeListEvent] that must be dispatch to [PracticeListBloc]
abstract class PracticeListEvent extends Equatable {
  const PracticeListEvent();

  @override
  String toString() => 'PracticeListEvent{}';
}

class PracticeListLoad extends PracticeListEvent implements PracticeListParams {
  @override
  final String? ofArtist;
  @override
  final String? ofDance;
  @override
  final String? ofFigure;
  @override
  final String? ofVideo;

  const PracticeListLoad({
    this.ofArtist,
    this.ofDance,
    this.ofFigure,
    this.ofVideo,
  });

  @override
  List<Object?> get props => [ofArtist, ofDance, ofFigure, ofVideo];

  @override
  String toString() {
    return 'PracticeListLoadMore{'
        'ofArtist: $ofArtist, '
        'ofDance: $ofDance, '
        'ofFigure: $ofFigure, '
        'ofVideo: $ofVideo'
        '}';
  }
}

class PracticeListLoadMore extends PracticeListEvent {
  const PracticeListLoadMore();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'PracticeListLoadMore{}';
}

class PracticeListRefresh extends PracticeListEvent {
  const PracticeListRefresh();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'PracticeListRefresh{}';
}

class PracticeListSelect extends PracticeListEvent {
  final String practiceId;

  const PracticeListSelect({
    required this.practiceId,
  });

  @override
  List<Object?> get props => [practiceId];

  @override
  String toString() => 'PracticeListSelect{'
      'practiceId: $practiceId'
      '}';
}

class PracticeListUnselect extends PracticeListEvent {
  final String? practiceId;

  const PracticeListUnselect({
    this.practiceId,
  });

  @override
  List<Object?> get props => [practiceId];

  @override
  String toString() => 'PracticeListUnselect{'
      'practiceId: $practiceId'
      '}';
}

class PracticeListDelete extends PracticeListEvent {
  const PracticeListDelete();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'PracticeListDelete{'
      '}';
}
