import 'package:kedis/features2/menu/create_a_schedule/domain/entities/create_lesson_entity.dart';

class CreateLessonModel extends CreateLessonEntity {
  const CreateLessonModel({
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

  factory CreateLessonModel.fromJson(Map<String, dynamic> json) {
    return CreateLessonModel(
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
