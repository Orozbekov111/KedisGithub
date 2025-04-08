import 'package:kedis/features2/menu/create_and_update_user/data/models/menu_user_model.dart';
import 'package:kedis/features2/menu/create_and_update_user/domain/repositories/menu_user_repository.dart';

class MenuGetCurrentUserUsecase {
  final MenuUserRepository repository;

  MenuGetCurrentUserUsecase({required this.repository});

  Future<MenuUserModel> call() async {
    return await repository.getCurrentUser();
  }
}
