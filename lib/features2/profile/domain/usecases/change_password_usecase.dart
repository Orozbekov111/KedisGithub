import 'package:kedis/features2/profile/domain/repositories/user_repository.dart';

class ChangePasswordUseCase {
  final UserRepository repository;

  ChangePasswordUseCase(this.repository);

  Future<void> execute(String newPassword, String currentPassword) async {
    await repository.changePassword(newPassword, currentPassword);
  }
}