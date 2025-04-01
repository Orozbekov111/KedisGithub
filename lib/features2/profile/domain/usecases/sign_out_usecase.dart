
import 'package:kedis/features2/profile/domain/repositories/user_repository.dart';

class SignOutUseCase {
  final UserRepository repository;

  SignOutUseCase(this.repository);

  Future<void> execute() async {
    await repository.signOut();
  }
}