part of 'schedule_bloc.dart';

abstract class ScheduleState extends Equatable {
  final String groupId;
  final String dayOfWeek;
  final List<lessonEntity> lessons;

  const ScheduleState({
    required this.groupId,
    required this.dayOfWeek,
    required this.lessons,
  });

  @override
  List<Object> get props => [groupId, dayOfWeek, lessons];
}

class ScheduleInitial extends ScheduleState {
  const ScheduleInitial({
    required String groupId,
    required String dayOfWeek,
  }) : super(
          groupId: groupId,
          dayOfWeek: dayOfWeek,
          lessons: const [],
        );
}

class ScheduleLoading extends ScheduleState {
  const ScheduleLoading({
    required String groupId,
    required String dayOfWeek,
    List<lessonEntity> lessons = const [],
  }) : super(
          groupId: groupId,
          dayOfWeek: dayOfWeek,
          lessons: lessons,
        );
}

class ScheduleLoaded extends ScheduleState {
  const ScheduleLoaded({
    required String groupId,
    required String dayOfWeek,
    required List<lessonEntity> lessons,
  }) : super(
          groupId: groupId,
          dayOfWeek: dayOfWeek,
          lessons: lessons,
        );
}

class ScheduleError extends ScheduleState {
  final String message;

  const ScheduleError({
    required String groupId,
    required String dayOfWeek,
    required this.message,
    List<lessonEntity> lessons = const [],
  }) : super(
          groupId: groupId,
          dayOfWeek: dayOfWeek,
          lessons: lessons,
        );

  @override
  List<Object> get props => [...super.props, message];
}

class ScheduleSuccess extends ScheduleState {
  final String message;

  const ScheduleSuccess({
    required String groupId,
    required String dayOfWeek,
    required this.message,
    List<lessonEntity> lessons = const [],
  }) : super(
          groupId: groupId,
          dayOfWeek: dayOfWeek,
          lessons: lessons,
        );

  @override
  List<Object> get props => [...super.props, message];
}