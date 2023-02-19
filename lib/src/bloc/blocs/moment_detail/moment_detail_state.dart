import 'package:dance/presentation.dart';
import 'package:equatable/equatable.dart';
import 'package:quiver/core.dart';

enum MomentDetailStatus {
  initial,
  loading,
  loadingSuccess,
  loadingFailure,
  refreshing,
  refreshingSuccess,
  refreshingFailure,
  deleteSuccess,
  deleteFailure,
}

class MomentDetailState extends Equatable {
  final MomentDetailStatus status;
  final String? ofMomentId;
  final MomentViewModel? moment;
  final Error? error;

  const MomentDetailState({
    this.status = MomentDetailStatus.initial,
    this.ofMomentId,
    this.moment,
    this.error,
  }) : super();

  @override
  List<Object?> get props => [
        status,
        ofMomentId,
        moment,
        error,
      ];

  MomentDetailState copyWith({
    MomentDetailStatus? status,
    Optional<String>? ofMomentId,
    Optional<MomentViewModel>? moment,
    Optional<Error>? error,
  }) {
    return MomentDetailState(
      status: status ?? this.status,
      ofMomentId: ofMomentId != null ? ofMomentId.orNull : this.ofMomentId,
      moment: moment != null ? moment.orNull : this.moment,
      error: error != null ? error.orNull : this.error,
    );
  }

  @override
  String toString() => 'MomentDetailLoaded{'
      'status: $status, '
      'ofId: $ofMomentId, '
      'moment: $moment, '
      'error: $error'
      '}';
}
