

import 'package:kedis/features2/profile/domain/entities/user_entity.dart';
import 'package:kedis/features2/profile/domain/repositories/user_repository.dart';

class GetUserUseCase {
  final UserRepository repository;

  GetUserUseCase(this.repository);

  Future<UserEntity> execute(String userId) async {
    return await repository.getUser(userId);
  }
}