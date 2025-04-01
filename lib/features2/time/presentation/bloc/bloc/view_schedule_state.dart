import 'package:equatable/equatable.dart';
import 'package:kedis/features2/time/domain/entities/view_schedule_entity.dart';
import 'package:kedis/features2/time/domain/entities/view_user_entity.dart';

abstract class ScheduleState extends Equatable {
  const ScheduleState();

  @override
  List<Object> get props => [];
}

class ScheduleInitial extends ScheduleState {}

class ScheduleLoading extends ScheduleState {}

class UserHasNoGroup extends ScheduleState {}

class ScheduleLoaded extends ScheduleState {
  final AppUser user;
  final Schedule schedule;

  const ScheduleLoaded({
    required this.user,
    required this.schedule,
  });

  @override
  List<Object> get props => [user, schedule];
}

class ScheduleError extends ScheduleState {
  final String message;

  const ScheduleError(this.message);

  @override
  List<Object> get props => [message];
}