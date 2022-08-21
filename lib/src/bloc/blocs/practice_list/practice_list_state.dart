import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:equatable/equatable.dart';

enum PracticeListStatus { initial, loading, refreshing, success, failure }

class PracticeListState extends Equatable implements PracticeListParams {
  final PracticeListStatus status;

  @override
  final String? ofArtist;
  @override
  final String? ofDance;
  @override
  final String? ofFigure;
  @override
  final String? ofVideo;

  final List<PracticeViewModel> practices;
  final bool hasReachedMax;
  final List<String> selectedPractices;
  final Error? error;

  const PracticeListState({
    this.status = PracticeListStatus.initial,
    this.ofArtist,
    this.ofDance,
    this.ofFigure,
    this.ofVideo,
    this.practices = const <PracticeViewModel>[],
    this.hasReachedMax = false,
    this.selectedPractices = const <String>[],
    this.error,
  });

  @override
  List<Object?> get props => [
        status,
        ofArtist,
        ofDance,
        ofFigure,
        ofVideo,
        practices,
        hasReachedMax,
        selectedPractices,
        error,
      ];

  PracticeListState copyWith({
    PracticeListStatus? status,
    String? ofArtist,
    String? ofDance,
    String? ofFigure,
    String? ofVideo,
    List<PracticeViewModel>? practices,
    bool? hasReachedMax,
    List<String>? selectedPractices,
    Error? error,
  }) {
    return PracticeListState(
      status: status ?? this.status,
      ofArtist: ofArtist ?? this.ofArtist,
      ofDance: ofDance ?? this.ofDance,
      ofFigure: ofFigure ?? this.ofFigure,
      ofVideo: ofVideo ?? this.ofVideo,
      practices: practices ?? this.practices,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      selectedPractices: selectedPractices ?? this.selectedPractices,
      error: error ?? this.error,
    );
  }

  @override
  String toString() => 'PracticeListState{'
      'status: $status, '
      'ofArtist: $ofArtist, '
      'ofDance: $ofDance, '
      'ofFigure: $ofFigure, '
      'ofVideo: $ofVideo, '
      'practices: $practices, '
      'hasReachedMax: $hasReachedMax, '
      'selectedPractices: $selectedPractices, '
      'error: $error'
      '}';
}
