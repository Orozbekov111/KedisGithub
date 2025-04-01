import 'package:kedis/features2/menu/create_a_schedule/domain/entities/lesson_entity.dart';

class LessonModel extends lessonEntity {
  const LessonModel({
    required String subject,
    required String time,
    required String teacherName,
    required String classroom,
  }) : super(
          subject: subject,
          time: time,
          teacherName: teacherName,
          classroom: classroom,
        );

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      subject: json['subject'],
      time: json['time'],
      teacherName: json['teacherName'],
      classroom: json['classroom'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subject': subject,
      'time': time,
      'teacherName': teacherName,
      'classroom': classroom,
    };
  }
}