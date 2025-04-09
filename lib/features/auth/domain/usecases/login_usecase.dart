import 'package:kedis/features/auth/domain/entities/user_entity.dart';
import 'package:kedis/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase({required this.repository});

  Future<UserEntity> execute(String email, String password) async {
    return await repository.login(email, password);
  }
}
