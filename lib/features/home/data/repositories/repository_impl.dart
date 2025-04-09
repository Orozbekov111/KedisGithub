import 'package:kedis/features/home/data/datasources/firebase_data_source.dart';
import 'package:kedis/features/home/domain/entities/user_entity.dart';
import 'package:kedis/features/home/domain/repositories/get_users_repository.dart';

class GetRepositoryImpl implements GetUsersRepository {
  final FirebaseGetDataSource dataSource;

  @override
  Future<UserEntity> getCurrentUser() async {
    final currentUserModel = await dataSource.getCurrentUser();
    return currentUserModel.toEntity();
  }

  GetRepositoryImpl({required this.dataSource});

  @override
  Future<List<UserEntity>> getUsersByGroup(String group) async {
    final users = await dataSource.getUsersByGroup(group);
    return users.map((user) => user.toEntity()).toList();
  }

  @override
  Future<List<UserEntity>> getTeachers() async {
    final teachers = await dataSource.getTeachers();
    return teachers.map((teacher) => teacher.toEntity()).toList();
  }

  @override
  Future<List<UserEntity>> getActiveStudents() async {
    final activeStudents = await dataSource.getActiveStudents();
    return activeStudents
        .map((activeStudents) => activeStudents.toEntity())
        .toList();
  }

  @override
  Future<List<UserEntity>> getBestStudents() async {
    final bestStudents = await dataSource.getBestStudents();
    return bestStudents.map((bestStudents) => bestStudents.toEntity()).toList();
  }

  @override
  Future<List<UserEntity>> getStudentexpelled() async {
    final studentsExpelled = await dataSource.getStudentexpelled();
    return studentsExpelled
        .map((studentsExpelled) => studentsExpelled.toEntity())
        .toList();
  }
}
