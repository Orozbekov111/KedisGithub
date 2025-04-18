import 'package:kedis/features/menu/create_a_schedule/domain/entities/create_schedule_entity.dart';
import 'package:kedis/features/menu/create_a_schedule/domain/repositories/create_schedule_repository.dart';

class AddScheduleUsecase {
  final CreateScheduleRepository repository;

  AddScheduleUsecase({required this.repository});

  Future<void> call(CreateScheduleEntity schedule) async {
    if (schedule.lessons.isEmpty) {
      throw Exception('Не удается добавить пустое расписание');
    }
    await repository.addSchedule(schedule);
  }
}
