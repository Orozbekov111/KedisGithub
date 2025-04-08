import 'package:kedis/features2/menu/create_and_update_user/data/models/menu_user_model.dart';
import 'package:kedis/features2/menu/create_and_update_user/domain/repositories/menu_user_repository.dart';

class MenuCreateUserUsecase {
  final MenuUserRepository repository;

  MenuCreateUserUsecase({required this.repository});

  Future<void> call(MenuUserModel user) async {
    return await repository.createUser(user);
  }
}