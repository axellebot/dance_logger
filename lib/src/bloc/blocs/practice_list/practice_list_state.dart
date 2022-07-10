import 'package:dance/presentation.dart';
import 'package:equatable/equatable.dart';

abstract class PracticeListState extends Equatable {
  const PracticeListState();

  @override
  String toString() => 'PracticeListState{}';
}

class PracticeListUninitialized extends PracticeListState {
  const PracticeListUninitialized();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'PracticeListUninitialized{}';
}

class PracticeListRefreshing extends PracticeListState {
  const PracticeListRefreshing();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'PracticeListRefreshing{}';
}

class PracticeListLoaded extends PracticeListState {
  final List<PracticeViewModel> practices;
  final bool hasReachedMax;

  const PracticeListLoaded({
    required this.practices,
    required this.hasReachedMax,
  });

  @override
  List<Object?> get props => [practices, hasReachedMax];

  PracticeListLoaded copyWith({
    List<PracticeViewModel>? practices,
    bool? hasReachedMax,
  }) {
    return PracticeListLoaded(
      practices: practices ?? this.practices,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() => 'PracticeListLoaded{'
      'practices: $practices, '
      'hasReachedMax: $hasReachedMax'
      '}';
}

class PracticeListFailed extends PracticeListState {
  final Error error;

  const PracticeListFailed({required this.error});

  @override
  List<Object?> get props => [error];

  @override
  String toString() => 'PracticeListFailed{'
      'error: $error'
      '}';
}
