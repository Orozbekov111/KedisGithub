import 'package:firebase_auth/firebase_auth.dart';
import 'package:kedis/features/auth/domain/entities/user_entity.dart';

class FirebaseAuthRemoteDataSource {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<UserEntity> login(String email, String password) async {
    final userCredential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (userCredential.user == null) {
      throw Exception('Пользователь имеет значение null после входа в систему');
    }

    return UserEntity(
      id: userCredential.user!.uid,
      email: userCredential.user!.email ?? '',
      // fullName: userCredential.user!.displayName ?? 'Неизвестный',
    );
  }

  Future<bool> isAuthenticated() async {
    return firebaseAuth.currentUser != null;
  }
}
