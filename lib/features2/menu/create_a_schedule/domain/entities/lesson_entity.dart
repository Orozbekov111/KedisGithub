class lessonEntity {
  final String subject;
  final String time;
  final String teacherName;
  final String classroom;

  const lessonEntity({
    required this.subject,
    required this.time,
    required this.teacherName,
    required this.classroom,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is lessonEntity &&
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