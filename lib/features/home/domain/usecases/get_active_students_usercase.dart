import 'package:kedis/features/home/domain/entities/user_entity.dart';
import 'package:kedis/features/home/domain/repositories/get_users_repository.dart';

class GetActiveStudentsUserCase {
  final GetUsersRepository repository;

  GetActiveStudentsUserCase(this.repository);

  Future<List<UserEntity>> execute() async {
    return await repository.getActiveStudents();
  }
}
