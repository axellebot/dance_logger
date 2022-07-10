import 'package:dance/bloc.dart';
import 'package:equatable/equatable.dart';

/// [PracticeListEvent] that must be dispatch to [PracticeListBloc]
abstract class PracticeListEvent extends Equatable {
  const PracticeListEvent();

  @override
  String toString() => 'PracticeListEvent{}';
}

class PracticeListRefresh extends PracticeListEvent {
  const PracticeListRefresh();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'PracticeListRefresh{}';
}

class PracticeListLoadMore extends PracticeListEvent {
  const PracticeListLoadMore();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'PracticeListLoadMore{}';
}
