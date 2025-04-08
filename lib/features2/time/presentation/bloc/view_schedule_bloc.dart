// bloc/schedule_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kedis/features2/time/domain/entities/view_schedule_entity.dart';
import 'package:kedis/features2/time/domain/usecases/get_schedule_usecase.dart';

part 'view_schedule_event.dart';
part 'view_schedule_state.dart';

class ViewScheduleBloc extends Bloc<ViewScheduleEvent, ViewScheduleState> {
  final GetScheduleUsecase getScheduleUsecase;

  ViewScheduleBloc({required this.getScheduleUsecase}) : super(ViewScheduleInitial()) {
    on<ViewLoadScheduleEvent>(_onLoadSchedule);
  }

  Future<void> _onLoadSchedule(
    ViewLoadScheduleEvent event,
    Emitter<ViewScheduleState> emit,
  ) async {
    emit(VievScheduleLoading());
    try {
      final schedule = await getScheduleUsecase();
      emit(ViewScheduleLoaded(schedule));
    } catch (e) {
      emit(ViewScheduleError('Ошибка загрузки расписания: ${e.toString()}'));
    }
  }
}