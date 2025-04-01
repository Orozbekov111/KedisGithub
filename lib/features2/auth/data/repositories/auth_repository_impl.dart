import 'package:kedis/features2/auth/data/datasources/firebase_auth_remote_data_source.dart';
import 'package:kedis/features2/auth/domain/entities/user_entity.dart';
import 'package:kedis/features2/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<UserEntity> login(String email, String password) async {
    return await remoteDataSource.login(email, password);
  }

  @override
  Future<bool> isAuthenticated() async {
    return await remoteDataSource.isAuthenticated();
  }
}