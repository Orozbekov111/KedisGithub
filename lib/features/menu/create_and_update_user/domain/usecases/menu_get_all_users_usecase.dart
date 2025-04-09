import 'package:kedis/features/menu/create_and_update_user/data/models/menu_user_model.dart';
import 'package:kedis/features/menu/create_and_update_user/domain/repositories/menu_user_repository.dart';

class MenuGetAllUsersUsecase {
  final MenuUserRepository repository;

  MenuGetAllUsersUsecase({required this.repository});

  Future<List<MenuUserModel>> call() async {
    return await repository.getAllUsers();
  }
}