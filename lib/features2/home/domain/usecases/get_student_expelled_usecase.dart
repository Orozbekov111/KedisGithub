import 'package:kedis/features2/home/domain/entities/user_entity.dart';
import 'package:kedis/features2/home/domain/repositories/get_users_repository.dart';

class GetStudentsExpelledUsecase {
  final GetUsersRepository repository;

  GetStudentsExpelledUsecase(this.repository);

  Future<List<UserEntity>> execute() async {
    return await repository.getStudentexpelled();
  }
}
