import 'package:kedis/features/home/domain/entities/user_entity.dart';

abstract class GetUsersRepository {
  Future<UserEntity> getCurrentUser();
  Future<List<UserEntity>> getUsersByGroup(String group);
  Future<List<UserEntity>> getTeachers();
  Future<List<UserEntity>> getActiveStudents();
  Future<List<UserEntity>> getBestStudents();
  Future<List<UserEntity>> getStudentexpelled();
}
