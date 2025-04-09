import 'package:kedis/features/menu/create_a_schedule/data/datasources/create_schedule_firebase_data_source.dart';
import 'package:kedis/features/menu/create_a_schedule/domain/entities/create_schedule_entity.dart';
import 'package:kedis/features/menu/create_a_schedule/domain/repositories/create_schedule_repository.dart';

class CreateScheduleRepositoryImpl implements CreateScheduleRepository {
  final CreateScheduleFirebaseDataSource firestoreDataSource;

  CreateScheduleRepositoryImpl({required this.firestoreDataSource});

  @override
  Future<void> addSchedule(CreateScheduleEntity schedule) async {
    await firestoreDataSource.addSchedule(schedule);
  }

  @override
  Future<void> createGroup(String groupId, String groupName) async {
    await firestoreDataSource.createGroup(groupId, groupName);
  }
}
