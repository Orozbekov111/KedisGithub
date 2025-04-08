import 'package:kedis/features2/profile/data/datasources/firebase_user_data_source.dart';
import 'package:kedis/features2/profile/domain/entities/user_entity.dart';
import 'package:kedis/features2/profile/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseUserDataSource dataSource;

  UserRepositoryImpl({required this.dataSource});

  @override
  Future<UserEntity> getUser(String userId) async {
    final userModel = await dataSource.getUser(userId);
    return userModel.toEntity(); 
  }

  @override
  Future<void> signOut() async {
    await dataSource.signOut();
  }

  @override
  Future<void> changePassword(String newPassword, String currentPassword) async {
    await dataSource.changePassword(newPassword, currentPassword);
  }
}