import 'dart:async';

import 'package:dance/data.dart';
import 'package:dance/domain.dart';

abstract class PracticeDataStore {
  FutureOr<PracticeDataModel> setPractice(PracticeDataModel practiceModel);

  FutureOr<PracticeDataModel> getPractice(String practiceId);

  FutureOr<void> deletePractice(String practiceId);

  FutureOr<List<PracticeDataModel>> getPractices({
    /// TODO: Add filters
    /// TODO: Add sort
    required Offset offset,
  });

  FutureOr<List<PracticeDataModel>> getPracticesOfFigure(
    String figureId, {

    /// TODO: Add filters
    /// TODO: Add sort
    required Offset offset,
  });

  FutureOr<List<PracticeDataModel>> getPracticesOfUser(
    String userId, {

    /// TODO: Add filters
    /// TODO: Add sort
    required Offset offset,
  });
}
