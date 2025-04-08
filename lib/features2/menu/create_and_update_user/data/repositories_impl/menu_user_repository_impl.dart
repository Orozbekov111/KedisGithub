import 'package:kedis/features2/menu/create_and_update_user/data/datasources/menu_firebase_user_data_source.dart';
import 'package:kedis/features2/menu/create_and_update_user/data/models/menu_user_model.dart';
import 'package:kedis/features2/menu/create_and_update_user/domain/repositories/menu_user_repository.dart';

class MenuUserRepositoryImpl implements MenuUserRepository {
  final MenuFirebaseUserDataSource firestoreDataSource;

  MenuUserRepositoryImpl({required this.firestoreDataSource});

  @override
  Future<MenuUserModel> getCurrentUser() async {
    return await firestoreDataSource.getCurrentUser();
  }

  @override
  Future<void> createUser(MenuUserModel user) async {
    await firestoreDataSource.createUser(user);
  }

  @override
  Future<List<MenuUserModel>> getAllUsers() async {
    return await firestoreDataSource.getAllUsers();
  }

  @override
  Future<void> updateUser(MenuUserModel user) async {
    await firestoreDataSource.updateUser(user);
  }

  @override
  Future<void> deleteUser(String userId) async {
    await firestoreDataSource.deleteUser(userId);
  }
}
