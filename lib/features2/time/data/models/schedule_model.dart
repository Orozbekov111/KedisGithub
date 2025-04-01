class ScheduleModel {
  final String groupId;
  final String day;
  final List<LessonModel> lessons;

  ScheduleModel({
    required this.groupId,
    required this.day,
    required this.lessons,
  });

  factory ScheduleModel.fromFirestore(Map<String, dynamic> data, String day) {
    final lessons = (data['lessons'] as List? ?? [])
        .map((lesson) => LessonModel.fromMap(lesson))
        .toList();

    return ScheduleModel(
      groupId: data['groupId'] ?? '',
      day: day,
      lessons: lessons,
    );
  }
}

class LessonModel {
  final String subject;
  final String time;
  final String? teacher;
  final String? classroom;

  LessonModel({
    required this.subject,
    required this.time,
    this.teacher,
    this.classroom,
  });

  factory LessonModel.fromMap(Map<String, dynamic> map) {
    return LessonModel(
      subject: map['subject'] ?? '',
      time: map['time'] ?? '',
      teacher: map['teacher'],
      classroom: map['classroom'],
    );
  }
}