// bloc/schedule_event.dart
part of 'view_schedule_bloc.dart';

abstract class ViewScheduleEvent extends Equatable {
  const ViewScheduleEvent();

  @override
  List<Object> get props => [];
}

class ViewLoadScheduleEvent extends ViewScheduleEvent {}