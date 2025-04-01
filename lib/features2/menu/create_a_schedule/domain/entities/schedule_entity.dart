import 'package:kedis/features2/menu/create_a_schedule/domain/entities/lesson_entity.dart';

class ScheduleEntity {
  final String groupId;
  final String dayOfWeek;
  final List<lessonEntity> lessons;

  const ScheduleEntity({
    required this.groupId,
    required this.dayOfWeek,
    required this.lessons,
  });
}