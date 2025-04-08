import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kedis/features2/home/data/models/user_model.dart';

class FirebaseGetDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel> getCurrentUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('User not authenticated');
    final doc = await _firestore.collection('users').doc(user.uid).get();
    if (!doc.exists) throw Exception('User document not found');
    return UserModel.fromFirestore(doc);
  }

  Future<List<UserModel>> getUsersByGroup(String group) async {
    final querySnapshot =
        await _firestore
            .collection('users')
            .where('group', isEqualTo: group)
            .get();

    return querySnapshot.docs
        .map((doc) => UserModel.fromFirestore(doc))
        .toList();
  }

  Future<List<UserModel>> getTeachers() async {
    final querySnapshot =
        await _firestore
            .collection('users')
            .where('role', isEqualTo: 'Преподаватель')
            .get();
    return querySnapshot.docs
        .map((doc) => UserModel.fromFirestore(doc))
        .toList();
  }

  Future<List<UserModel>> getActiveStudents() async {
    final querySnapshot =
        await _firestore
            .collection('users')
            .where('code', isEqualTo: 'active')
            .get();
    return querySnapshot.docs
        .map((doc) => UserModel.fromFirestore(doc))
        .toList();
  }

  Future<List<UserModel>> getBestStudents() async {
    final querySnapshot =
        await _firestore
            .collection('users')
            .where('code', isEqualTo: 'top')
            .get();
    return querySnapshot.docs
        .map((doc) => UserModel.fromFirestore(doc))
        .toList();
  }

  Future<List<UserModel>> getStudentexpelled() async {
    final querySnapshot =
        await _firestore
            .collection('users')
            .where('code', isEqualTo: 'expulsion')
            .get();
    return querySnapshot.docs
        .map((doc) => UserModel.fromFirestore(doc))
        .toList();
  }
}
