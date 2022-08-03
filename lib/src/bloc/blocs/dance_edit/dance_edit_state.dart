import 'package:dance/presentation.dart';
import 'package:equatable/equatable.dart';

enum DanceEditStatus { initial, loading, success, failure }

abstract class DanceEditState extends Equatable {
  const DanceEditState() : super();

  @override
  String toString() => 'DanceState{}';
}

class DanceEditUninitialized extends DanceEditState {
  const DanceEditUninitialized();

  @override
  List<Object?> get props => [];
}

class DanceEditLoading extends DanceEditState {
  const DanceEditLoading() : super();

  @override
  List<Object?> get props => [];
}

class DanceEditLoaded extends DanceEditState {
  final DanceViewModel dance;

  const DanceEditLoaded({
    required this.dance,
  }) : super();

  @override
  List<Object?> get props => [dance];

  @override
  String toString() {
    return 'DanceEditLoaded{'
        'dance: $dance'
        '}';
  }
}

class DanceEditFailed extends DanceEditState {
  final Error error;

  const DanceEditFailed({required this.error}) : super();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'DanceEditFailed {'
      'error: $error'
      '}';
}
