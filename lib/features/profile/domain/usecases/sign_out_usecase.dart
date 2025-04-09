
import 'package:kedis/features/profile/domain/repositories/user_repository.dart';

class SignOutUseCase {
  final UserRepository repository;

  SignOutUseCase(this.repository);

  Future<void> execute() async {
    await repository.signOut();
  }
}