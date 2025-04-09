import 'package:kedis/features/time/domain/entities/view_schedule_entity.dart';
import 'package:kedis/features/time/domain/repositories/view_schedule_repository.dart';

class GetScheduleUsecase {
  final ScheduleRepository repository;

  GetScheduleUsecase({required this.repository});

  Future<ViewScheduleEntity> call() async {
    return await repository.getSchedule();
  }
}