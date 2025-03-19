import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kedis/features2/profile/data/models/user_model.dart';

// Источник данных для работы с Firebase (Firestore и Auth)
class FirebaseUserDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Получение пользователя по ID
  Future<UserModel> getUser(String userId) async {
    try {
      if (userId.isEmpty) {
        throw Exception('User ID is empty');
      }

      final userDoc = await _firestore.collection('users').doc(userId).get();

      if (!userDoc.exists) {
        throw Exception('User not found in Firestore');
      }

      return UserModel.fromFirestore(userDoc);
    } catch (e) {
      print('Error in getUser: $e');
      rethrow;
    }
  }

  // Обновление данных пользователя
  Future<void> updateUser(UserModel user) async {
    await _firestore.collection('users').doc(user.id).update(user.toMap());
  }

  // Создание нового пользователя
  Future<void> createUser(UserModel user) async {
    await _firestore.collection('users').doc(user.id).set(user.toMap());
  }

}

