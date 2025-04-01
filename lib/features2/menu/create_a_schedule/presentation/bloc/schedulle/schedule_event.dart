part of 'schedule_bloc.dart';

abstract class ScheduleEvent extends Equatable {
  const ScheduleEvent();

  @override
  List<Object> get props => [];
}

class AddLessonEvent extends ScheduleEvent {
  final lessonEntity lesson;

  const AddLessonEvent(this.lesson);

  @override
  List<Object> get props => [lesson];
}

class SaveScheduleEvent extends ScheduleEvent {
  final String groupId;
  final String dayOfWeek;

  const SaveScheduleEvent(this.groupId, this.dayOfWeek);

  @override
  List<Object> get props => [groupId, dayOfWeek];
}

class ClearLessonsEvent extends ScheduleEvent {}