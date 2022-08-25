import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:equatable/equatable.dart';

/// [PracticeListEvent] that must be dispatch to [PracticeListBloc]
abstract class PracticeListEvent extends Equatable {
  const PracticeListEvent();

  @override
  String toString() => 'PracticeListEvent{}';
}

class PracticeListLoad extends PracticeListEvent implements PracticeListParams {
  /// PracticeListParams
  @override
  final String? ofArtist;
  @override
  final String? ofDance;
  @override
  final String? ofFigure;
  @override
  final String? ofVideo;

  const PracticeListLoad({
    /// PracticeListParams
    this.ofArtist,
    this.ofDance,
    this.ofFigure,
    this.ofVideo,
  });

  @override
  List<Object?> get props => [ofArtist, ofDance, ofFigure, ofVideo];

  @override
  String toString() => 'PracticeListLoadMore{'
      'ofArtist: $ofArtist, '
      'ofDance: $ofDance, '
      'ofFigure: $ofFigure, '
      'ofVideo: $ofVideo'
      '}';
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
  final PracticeViewModel practice;

  const PracticeListSelect({
    required this.practice,
  });

  @override
  List<Object?> get props => [practice];

  @override
  String toString() => 'PracticeListSelect{'
      'practiceId: $practice'
      '}';
}

class PracticeListUnselect extends PracticeListEvent {
  final PracticeViewModel? practice;

  const PracticeListUnselect({
    this.practice,
  });

  @override
  List<Object?> get props => [practice];

  @override
  String toString() => 'PracticeListUnselect{'
      'practiceId: $practice'
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
