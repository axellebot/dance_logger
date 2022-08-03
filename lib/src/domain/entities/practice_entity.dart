import 'package:dance/domain.dart';

enum PracticeStatus { none, low, medium, high }

abstract class PracticeEntity extends BaseEntity {
  late DateTime doneAt;
  late String status;
  late String figureId;
}
