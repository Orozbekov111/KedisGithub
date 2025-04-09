import 'package:kedis/features/menu/create_a_schedule/domain/entities/create_lesson_entity.dart';

class CreateScheduleEntity {
  final String groupId;
  final String dayOfWeek;
  final List<CreateLessonEntity> lessons;

  const CreateScheduleEntity({
    required this.groupId,
    required this.dayOfWeek,
    required this.lessons,
  });
}
