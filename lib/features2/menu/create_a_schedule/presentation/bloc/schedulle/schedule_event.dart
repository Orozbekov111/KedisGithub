part of 'schedule_bloc.dart';

abstract class CreateScheduleEvent extends Equatable {
  const CreateScheduleEvent();

  @override
  List<Object> get props => [];
}

class AddLessonEvent extends CreateScheduleEvent {
  final CreateLessonEntity lesson;

  const AddLessonEvent(this.lesson);

  @override
  List<Object> get props => [lesson];
}

class SaveScheduleEvent extends CreateScheduleEvent {
  final String groupId;
  final String dayOfWeek;

  const SaveScheduleEvent(this.groupId, this.dayOfWeek);

  @override
  List<Object> get props => [groupId, dayOfWeek];
}

class ClearLessonsEvent extends CreateScheduleEvent {}
