import 'package:kedis/features2/menu/create_and_update_user/data/datasources/menu_firebase_user_data_source.dart';
import 'package:kedis/features2/menu/create_and_update_user/data/models/menu_user_model.dart';
import 'package:kedis/features2/menu/create_and_update_user/domain/repositories/menu_user_repository.dart';

class MenuUserRepositoryImpl implements MenuUserRepository {
  final MenuFirebaseUserDataSource dataSource;

  MenuUserRepositoryImpl(this.dataSource);

  @override
  Future<MenuUserModel> getCurrentUser() async {
    return await dataSource.getCurrentUser();
  }

  @override
  Future<void> createUser(MenuUserModel user) async {
    await dataSource.createUser(user);
  }

  @override
  Future<List<MenuUserModel>> getAllUsers() async {
    return await dataSource.getAllUsers();
  }

  @override
  Future<void> updateUser(MenuUserModel user) async {
    await dataSource.updateUser(user);
  }

  @override
  Future<void> deleteUser(String userId) async {
    await dataSource.deleteUser(userId);
  }
}