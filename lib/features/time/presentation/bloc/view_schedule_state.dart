// bloc/schedule_state.dart
part of 'view_schedule_bloc.dart';

abstract class ViewScheduleState extends Equatable {
  const ViewScheduleState();

  @override
  List<Object> get props => [];
}

class ViewScheduleInitial extends ViewScheduleState {}

class VievScheduleLoading extends ViewScheduleState {}

class ViewScheduleLoaded extends ViewScheduleState {
  final ViewScheduleEntity schedule;

  const ViewScheduleLoaded(this.schedule);

  @override
  List<Object> get props => [schedule];
}

class ViewScheduleError extends ViewScheduleState {
  final String message;

  const ViewScheduleError(this.message);

  @override
  List<Object> get props => [message];
}