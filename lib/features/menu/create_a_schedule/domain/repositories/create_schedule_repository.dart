import 'package:kedis/features/menu/create_a_schedule/domain/entities/create_schedule_entity.dart';

abstract class CreateScheduleRepository {
  Future<void> addSchedule(CreateScheduleEntity schedule);
  Future<void> createGroup(String groupId, String groupName);
}
