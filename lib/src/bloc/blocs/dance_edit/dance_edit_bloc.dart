import 'dart:async';

import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class DanceEditBloc extends Bloc<DanceEditEvent, DanceEditState> {
  final DanceRepository danceRepository;
  final ModelMapper mapper;

  DanceEditBloc({
    required this.danceRepository,
    required this.mapper,
  }) : super(const DanceEditUninitialized()) {
    on<DanceEditStart>(_onDanceEditStart);
  }

  FutureOr<void> _onDanceEditStart(event, emit) async {
    emit(const DanceEditLoading());
    DanceViewModel danceViewModel;

    if (event.danceId != null) {
      DanceEntity danceDataModel =
          await danceRepository.getById(event.danceId!);
      danceViewModel = mapper.toDanceViewModel(danceDataModel);
    } else {
      danceViewModel = DanceViewModel(
        id: const Uuid().v4(),
        name: '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        version: 1,
      );
    }

    emit(DanceEditLoaded(dance: danceViewModel));
  }
}
