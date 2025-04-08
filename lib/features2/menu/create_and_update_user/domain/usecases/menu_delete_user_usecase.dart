import 'package:kedis/features2/menu/create_and_update_user/domain/repositories/menu_user_repository.dart';

class MenuDeleteUserUsecase {
  final MenuUserRepository repository;

  MenuDeleteUserUsecase({required this.repository});

  Future<void> call(String userId) async {
    return await repository.deleteUser(userId);
  }
}