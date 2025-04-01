
import 'package:kedis/features2/time/data/datasourses/view_schedule_remote_data_source.dart';
import 'package:kedis/features2/time/domain/entities/view_schedule_entity.dart';
import 'package:kedis/features2/time/domain/entities/view_user_entity.dart';
import 'package:kedis/features2/time/domain/repositories/view_schedule_repository.dart';

class ViewScheduleRepositoryImpl implements ViewScheduleRepository {
  final ViewScheduleRemoteDataSource remoteDataSource;

  ViewScheduleRepositoryImpl(this.remoteDataSource);

  @override
  Future<AppUser> getCurrentUser() async {
    return await remoteDataSource.getCurrentUser();
  }

  @override
  Future<Schedule> getGroupSchedule(String groupId, String groupName) async {
    return await remoteDataSource.getGroupSchedule(groupId, groupName);
  }
}