import 'package:kedis/features2/menu/create_a_schedule/domain/entities/schedule_entity.dart';
import 'package:kedis/features2/menu/create_a_schedule/domain/repositories/create_schedule_repository.dart';

class AddScheduleUsecase {
  final CreateScheduleRepository repository;

  AddScheduleUsecase(this.repository);

  Future<void> call(ScheduleEntity schedule) async {
    if (schedule.lessons.isEmpty) {
      throw Exception('Cannot add empty schedule');
    }
    await repository.addSchedule(schedule);
  }
}