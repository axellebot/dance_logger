import 'package:dance/bloc.dart';
import 'package:dance/presentation.dart';
import 'package:equatable/equatable.dart';

/// [MomentDetailEvent] that must be dispatch to [MomentDetailBloc]
abstract class MomentDetailEvent extends Equatable {
  const MomentDetailEvent() : super();

  @override
  String toString() => 'MomentDetailEvent{}';
}

class MomentDetailLazyLoad extends MomentDetailEvent {
  final MomentViewModel moment;

  const MomentDetailLazyLoad({
    required this.moment,
  }) : super();

  @override
  String toString() => 'MomentDetailLoad{'
      'moment: $moment'
      '}';

  @override
  List<Object?> get props => [moment];
}

class MomentDetailLoad extends MomentDetailEvent {
  final String momentId;

  const MomentDetailLoad({required this.momentId}) : super();

  @override
  String toString() => 'MomentDetailLoad{'
      'momentId: $momentId'
      '}';

  @override
  List<Object?> get props => [momentId];
}

class MomentDetailRefresh extends MomentDetailEvent {
  const MomentDetailRefresh();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'MomentDetailRefresh{}';
}

class MomentDetailDelete extends MomentDetailRefresh {
  const MomentDetailDelete() : super();

  @override
  String toString() => 'MomentDetailDelete{}';

  @override
  List<Object?> get props => [];
}
