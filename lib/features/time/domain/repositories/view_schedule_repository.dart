import 'package:kedis/features/time/domain/entities/view_schedule_entity.dart';

abstract class ScheduleRepository {
  Future<ViewScheduleEntity> getSchedule();
}