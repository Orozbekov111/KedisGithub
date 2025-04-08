import 'package:kedis/features2/time/domain/entities/view_lesson_entity.dart';

class ViewScheduleEntity {
  final String groupId;
  final String groupName;
  final Map<String, List<ViewLessonEntity>> dayLessons;

  ViewScheduleEntity({
    required this.groupId,
    required this.groupName,
    required this.dayLessons,
  });
}