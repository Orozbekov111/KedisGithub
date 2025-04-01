import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kedis/features2/time/domain/repositories/view_schedule_repository.dart';
import 'package:kedis/features2/time/presentation/bloc/bloc/view_schedule_event.dart';
import 'package:kedis/features2/time/presentation/bloc/bloc/view_schedule_state.dart';

class ViewScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final ViewScheduleRepository repository;
  final FirebaseFirestore firestore;

  ViewScheduleBloc({
    required this.repository,
    required this.firestore,
  }) : super(ScheduleInitial()) {
    on<ViewLoadScheduleEvent>(_onLoadSchedule);
  }

  Future<void> _onLoadSchedule(
    ViewLoadScheduleEvent event,
    Emitter<ScheduleState> emit,
  ) async {
    emit(ScheduleLoading());
    try {
      final user = await repository.getCurrentUser();
      
      if (user.groupId.isEmpty) {
        emit(UserHasNoGroup());
        return;
      }

      // First get the group document to get the group name
      final groupDoc = await firestore.collection('groups').doc(user.groupId).get();
      if (!groupDoc.exists) {
        emit(ScheduleError('Group not found'));
        return;
      }

      final groupName = groupDoc.data()?['name']?.toString() ?? 'Unnamed Group';
      
      // Now get the schedule with both groupId and groupName
      final schedule = await repository.getGroupSchedule(user.groupId, groupName);
      emit(ScheduleLoaded(user: user, schedule: schedule));
    } catch (e) {
      emit(ScheduleError(e.toString()));
    }
  }
}