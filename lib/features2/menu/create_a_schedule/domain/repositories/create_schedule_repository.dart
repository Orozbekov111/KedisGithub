import 'package:kedis/features2/menu/create_a_schedule/domain/entities/schedule_entity.dart';

abstract class CreateScheduleRepository {
  Future<void> addSchedule(ScheduleEntity schedule);
  Future<void> createGroup(String groupId, String groupName);
}