import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kedis/features/menu/create_and_update_user/data/models/menu_user_model.dart';

class MenuFirebaseUserDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<MenuUserModel> getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('Пользователь не прошел проверку подлинности');

      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (!doc.exists) throw Exception('Пользователь не найден');

      return MenuUserModel.fromFirestore(doc);
    } catch (e) {
      throw Exception('Не удалось получить доступ к пользователю: ${e.toString()}');
    }
  }

  Future<void> createUser(MenuUserModel user) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      final uid = userCredential.user?.uid;
      if (uid == null) throw Exception('Не удалось получить UID пользователя');

      await _firestore.collection('users').doc(uid).set({
        'email': user.email,
        'password': user.password, // Обычно пароль не хранят в Firestore
        'fullName': user.fullName,
        'emailUser': user.emailUser,
        'group': user.group,
        'profession': user.profession,
        'phone': user.phone,
        'specialty': user.specialty,
        'role': user.role,
        'code': user.code,
        'picture': user.picture,
      });
    } catch (e) {
      throw Exception('Не удалось создать пользователя: ${e.toString()}');
    }
  }

  Future<List<MenuUserModel>> getAllUsers() async {
    try {
      final snapshot = await _firestore.collection('users').get();
      return snapshot.docs
          .map((doc) => MenuUserModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Не удалось получить пользователей: ${e.toString()}');
    }
  }

  Future<void> updateUser(MenuUserModel user) async {
    try {
      await _firestore.collection('users').doc(user.id).update(user.toMap());
    } catch (e) {
      throw Exception('Не удалось обновить пользователя: ${e.toString()}');
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      await _firestore.collection('users').doc(userId).delete();
    } catch (e) {
      throw Exception('Не удалось удалить пользователя: ${e.toString()}');
    }
  }
}
