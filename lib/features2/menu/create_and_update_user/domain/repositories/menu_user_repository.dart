import 'package:kedis/features2/menu/create_and_update_user/data/models/menu_user_model.dart';

abstract class MenuUserRepository {
  Future<MenuUserModel> getCurrentUser();
  Future<void> createUser(MenuUserModel user);
  Future<List<MenuUserModel>> getAllUsers();
  Future<void> updateUser(MenuUserModel user);
  Future<void> deleteUser(String userId);
}
