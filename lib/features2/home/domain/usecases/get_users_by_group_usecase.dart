import 'package:kedis/features2/home/domain/entities/user_entity.dart';
import 'package:kedis/features2/home/domain/repositories/get_users_repository.dart';

class GetUsersByGroupUseCase {
  final GetUsersRepository repository;

  GetUsersByGroupUseCase(this.repository);

  Future<List<UserEntity>> execute(String group) async {
    return await repository.getUsersByGroup(group);
  }
}
