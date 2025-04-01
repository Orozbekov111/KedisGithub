import 'package:firebase_auth/firebase_auth.dart';
import 'package:kedis/features2/auth/domain/entities/user_entity.dart';

class FirebaseAuthRemoteDataSource {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  

  Future<UserEntity> login(String email, String password) async {
    final userCredential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (userCredential.user == null) {
      throw Exception('User is null after login');
    }

    return UserEntity(
      id: userCredential.user!.uid,
      email: userCredential.user!.email ?? '',
      fullName: userCredential.user!.displayName ?? 'Unknown',
    );
  }



  Future<bool> isAuthenticated() async {
    return firebaseAuth.currentUser != null;
  }
}