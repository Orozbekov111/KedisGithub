import 'package:kedis/features2/profile/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<UserEntity> getUser(String userId);
  Future<void> updateUser(UserEntity user);
  Future<void> createUser(UserEntity user);
}