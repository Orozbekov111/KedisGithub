class CreateLessonEntity {
  final String subject;
  final String time;
  final String teacherName;
  final String classroom;

  const CreateLessonEntity({
    required this.subject,
    required this.time,
    required this.teacherName,
    required this.classroom,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreateLessonEntity &&
          runtimeType == other.runtimeType &&
          subject == other.subject &&
          time == other.time &&
          teacherName == other.teacherName &&
          classroom == other.classroom;

  @override
  int get hashCode =>
      subject.hashCode ^
      time.hashCode ^
      teacherName.hashCode ^
      classroom.hashCode;
}
