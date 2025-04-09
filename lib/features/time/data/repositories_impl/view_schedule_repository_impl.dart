import 'package:kedis/features/time/data/datasourses/view_schedule_remote_data_source.dart';
import 'package:kedis/features/time/domain/entities/view_schedule_entity.dart';
import 'package:kedis/features/time/domain/repositories/view_schedule_repository.dart';

class ViewScheduleRepositoryImpl implements ScheduleRepository {
  final ViewScheduleRemoteDataSource remoteDataSource;

  ViewScheduleRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ViewScheduleEntity> getSchedule() async {
    return await remoteDataSource.getSchedule();
  }
}