import 'dart:async';

import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiver/core.dart';

class VideoRemoteBloc extends Bloc<VideoRemoteEvent, VideoRemoteState> {

  VideoRemoteBloc() : super(const VideoRemoteState()) {
    on<VideoRemoteToggleRemote>(_onToggleRemote);
  }

  FutureOr<void> _onToggleRemote(
    VideoRemoteToggleRemote event,
    Emitter<VideoRemoteState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onToggleRemote');
    try {
      emit(state.copyWith(
        remoteOpened: Optional.of(event.opened),
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        error: Optional.of(error),
      ));
    }
  }
}
