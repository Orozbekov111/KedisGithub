import 'package:kedis/features2/profile/data/datasources/firebase_user_data_source.dart';
import 'package:kedis/features2/profile/data/models/user_model.dart';
import 'package:kedis/features2/profile/domain/entities/user_entity.dart';
import 'package:kedis/features2/profile/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseUserDataSource dataSource;

  UserRepositoryImpl(this.dataSource);

  @override
  Future<UserEntity> getUser(String userId) async {
    final userModel = await dataSource.getUser(userId);
    return UserEntity(
      email: userModel.email,
      password: userModel.password,
      id: userModel.id,
      fullName: userModel.fullName,
      emailUser: userModel.emailUser,
      group: userModel.group,
      profession: userModel.profession,
      phone: userModel.phone,
      specialty: userModel.specialty,
      role: userModel.role,
      code: userModel.code,
      picture: userModel.picture,
    );
  }

  @override
  Future<void> updateUser(UserEntity user) async {
    final userModel = UserModel(
      email: user.email,
      password: user.password,
      id: user.id,
      fullName: user.fullName,
      emailUser: user.emailUser,
      group: user.group,
      profession: user.profession,
      phone: user.phone,
      specialty: user.specialty,
      role: user.role,
      code: user.code,
      picture: user.picture,
    );
    await dataSource.updateUser(userModel);
  }

  @override
  Future<void> createUser(UserEntity user) async {
    final userModel = UserModel(
      email: user.email,
      password: user.password,
      id: user.id,
      fullName: user.fullName,
      emailUser: user.emailUser,
      group: user.group,
      profession: user.profession,
      phone: user.phone,
      specialty: user.specialty,
      role: user.role,
      code: user.code,
      picture: user.picture,
    );
    await dataSource.createUser(userModel);
  }
}