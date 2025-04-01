import 'package:equatable/equatable.dart';

class Schedule extends Equatable {
  final String groupId;
  final String groupName;
  final Map<String, DaySchedule> days;

  const Schedule({
    required this.groupId,
    required this.groupName,
    required this.days,
  });

  @override
  List<Object?> get props => [groupId, groupName, days];
}

class DaySchedule extends Equatable {
  final String dayName;
  final List<Lesson> lessons;

  const DaySchedule({
    required this.dayName,
    required this.lessons,
  });

  @override
  List<Object?> get props => [dayName, lessons];
}

class Lesson extends Equatable {
  final String subject;
  final String time;
  final String teacher;
  final String classroom;

  const Lesson({
    required this.subject,
    required this.time,
    required this.teacher,
    required this.classroom,
  });

  @override
  List<Object?> get props => [subject, time, teacher, classroom];
}