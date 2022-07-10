import 'package:dance/presentation.dart';
import 'package:equatable/equatable.dart';

abstract class PracticeState extends Equatable {
  const PracticeState() : super();

  @override
  String toString() => 'PracticeState{}';
}

class PracticeUninitialized extends PracticeState {
  const PracticeUninitialized();

  @override
  List<Object?> get props => [];
}

class PracticeLoading extends PracticeState {
  const PracticeLoading() : super();

  @override
  List<Object?> get props => [];
}

class PracticeLoaded extends PracticeState {
  final PracticeViewModel practice;

  const PracticeLoaded({
    required this.practice,
  }) : super();

  @override
  List<Object?> get props => [practice];

  @override
  String toString() {
    return 'PracticeLoaded{'
        'practice: $practice'
        '}';
  }
}

class PracticeFailure extends PracticeState {
  final Error error;

  const PracticeFailure({required this.error}) : super();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'PracticeFailure{'
      'error: $error'
      '}';
}
