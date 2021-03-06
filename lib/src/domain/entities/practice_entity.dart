import 'package:dance/domain.dart';

enum PracticeStatus { none, low, medium, high }

abstract class PracticeEntity extends BaseEntity {
  late DateTime date;
  late String status;
}
