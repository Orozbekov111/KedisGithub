class ViewLessonEntity {
  final String subject;
  final String teacherName;
  final String time;
  final String classroom;

  ViewLessonEntity({
    required this.subject,
    required this.teacherName,
    required this.time,
    required this.classroom,
  });

  factory ViewLessonEntity.fromMap(Map<String, dynamic> map) {
    return ViewLessonEntity(
      subject: map['subject']?.toString() ?? 'Нет предмета',
      teacherName: map['teacherName']?.toString() ?? 'Нет данных',
      time: map['time']?.toString() ?? 'Нет данных',
      classroom: map['classroom']?.toString() ?? 'Нет данных',
    );
  }
}