import 'package:kedis/features2/time/domain/entities/view_schedule_entity.dart';
import 'package:kedis/features2/time/domain/entities/view_user_entity.dart';

abstract class ViewScheduleRepository {
  Future<AppUser> getCurrentUser();
  Future<Schedule> getGroupSchedule(String groupId, String groupName);
}