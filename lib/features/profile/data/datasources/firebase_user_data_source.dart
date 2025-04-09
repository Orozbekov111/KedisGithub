import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kedis/features/profile/data/models/user_model.dart';

// Источник данных для работы с Firebase (Firestore и Auth)

class FirebaseUserDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel> getUser(String userId) async {
    final userDoc = await _firestore
        .collection('users')
        .doc(userId)
        .get(GetOptions(source: Source.server)); // Загрузка с сервера
    return UserModel.fromFirestore(userDoc);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> changePassword(String newPassword, String currentPassword) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('Пользователь не аутентифицирован');

    final credential = EmailAuthProvider.credential(
      email: user.email!,
      password: currentPassword,
    );

    await user.reauthenticateWithCredential(credential);
    await user.updatePassword(newPassword);

    await _firestore.collection('users').doc(user.uid).update({
      'password': newPassword,
    });
  }
}