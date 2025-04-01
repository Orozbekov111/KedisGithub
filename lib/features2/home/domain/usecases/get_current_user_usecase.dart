import 'package:kedis/features2/home/domain/entities/user_entity.dart';
import 'package:kedis/features2/home/domain/repositories/get_users_repository.dart';

class GetCurrentUserUseCase {
  final GetUsersRepository repository;
  
  GetCurrentUserUseCase(this.repository);
  
  Future<UserEntity> execute() => repository.getCurrentUser();
}