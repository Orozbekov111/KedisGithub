part of 'schedule_bloc.dart';

abstract class CreateScheduleState extends Equatable {
  final String groupId;
  final String dayOfWeek;
  final List<CreateLessonEntity> lessons;

  const CreateScheduleState({
    required this.groupId,
    required this.dayOfWeek,
    required this.lessons,
  });

  @override
  List<Object> get props => [groupId, dayOfWeek, lessons];
}

class ScheduleInitial extends CreateScheduleState {
  const ScheduleInitial({required String groupId, required String dayOfWeek})
    : super(groupId: groupId, dayOfWeek: dayOfWeek, lessons: const []);
}

class ScheduleLoading extends CreateScheduleState {
  const ScheduleLoading({
    required String groupId,
    required String dayOfWeek,
    List<CreateLessonEntity> lessons = const [],
  }) : super(groupId: groupId, dayOfWeek: dayOfWeek, lessons: lessons);
}

class ScheduleLoaded extends CreateScheduleState {
  const ScheduleLoaded({
    required String groupId,
    required String dayOfWeek,
    required List<CreateLessonEntity> lessons,
  }) : super(groupId: groupId, dayOfWeek: dayOfWeek, lessons: lessons);
}

class ScheduleError extends CreateScheduleState {
  final String message;

  const ScheduleError({
    required String groupId,
    required String dayOfWeek,
    required this.message,
    List<CreateLessonEntity> lessons = const [],
  }) : super(groupId: groupId, dayOfWeek: dayOfWeek, lessons: lessons);

  @override
  List<Object> get props => [...super.props, message];
}

class ScheduleSuccess extends CreateScheduleState {
  final String message;

  const ScheduleSuccess({
    required String groupId,
    required String dayOfWeek,
    required this.message,
    List<CreateLessonEntity> lessons = const [],
  }) : super(groupId: groupId, dayOfWeek: dayOfWeek, lessons: lessons);

  @override
  List<Object> get props => [...super.props, message];
}
