import 'package:kedis/features2/profile/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<UserEntity> getUser(String userId);
  Future<void> signOut();
  Future<void> changePassword(String newPassword, String currentPassword);
}