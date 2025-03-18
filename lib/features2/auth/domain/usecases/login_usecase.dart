import 'package:kedis/features2/auth/domain/repositories/auth_repository.dart';
import 'package:kedis/features2/auth/domain/entities/user_entity.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase({required this.repository});

  Future<UserEntity> call(String email, String password) async {
    return await repository.login(email, password);
  }
}