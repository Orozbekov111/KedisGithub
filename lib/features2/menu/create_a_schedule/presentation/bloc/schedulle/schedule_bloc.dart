import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kedis/features2/menu/create_a_schedule/domain/entities/lesson_entity.dart';
import 'package:kedis/features2/menu/create_a_schedule/domain/entities/schedule_entity.dart';
import 'package:kedis/features2/menu/create_a_schedule/domain/usecases/add_schedule_usecase.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final AddScheduleUsecase addSchedule;

  ScheduleBloc({
    required this.addSchedule,
    required String groupId,
    required String dayOfWeek,
  }) : super(ScheduleInitial(
          groupId: groupId,
          dayOfWeek: dayOfWeek,
        )) {
    on<AddLessonEvent>(_onAddLesson);
    on<SaveScheduleEvent>(_onSaveSchedule);
    on<ClearLessonsEvent>(_onClearLessons);
  }

  void _onAddLesson(AddLessonEvent event, Emitter<ScheduleState> emit) {
    final newLessons = List<lessonEntity>.from(state.lessons)..add(event.lesson);
    emit(ScheduleLoaded(
      groupId: state.groupId,
      dayOfWeek: state.dayOfWeek,
      lessons: newLessons,
    ));
  }

  Future<void> _onSaveSchedule(
      SaveScheduleEvent event, Emitter<ScheduleState> emit) async {
    emit(ScheduleLoading(
      groupId: state.groupId,
      dayOfWeek: state.dayOfWeek,
      lessons: state.lessons,
    ));
    
    try {
      await addSchedule(ScheduleEntity(
        groupId: state.groupId,
        dayOfWeek: state.dayOfWeek,
        lessons: state.lessons,
      ));
      
      emit(ScheduleSuccess(
        groupId: state.groupId,
        dayOfWeek: state.dayOfWeek,
        message: 'Schedule saved successfully',
        lessons: state.lessons,
      ));
    } catch (e) {
      emit(ScheduleError(
        groupId: state.groupId,
        dayOfWeek: state.dayOfWeek,
        message: e.toString(),
        lessons: state.lessons,
      ));
    }
  }

  void _onClearLessons(ClearLessonsEvent event, Emitter<ScheduleState> emit) {
    emit(ScheduleInitial(
      groupId: state.groupId,
      dayOfWeek: state.dayOfWeek,
    ));
  }
}