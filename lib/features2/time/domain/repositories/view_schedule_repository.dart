import 'package:kedis/features2/time/domain/entities/view_schedule_entity.dart';

abstract class ScheduleRepository {
  Future<ViewScheduleEntity> getSchedule();
}