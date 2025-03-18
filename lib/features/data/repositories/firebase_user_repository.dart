import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

class FirebaseUserRepository {
  final FirebaseAuth _firebaseAuth;
  final CollectionReference usersCollection;

  FirebaseUserRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        usersCollection = FirebaseFirestore.instance.collection('users');

  // Поток для получения текущего аутентифицированного пользователя
  @override
  Stream<UserModel?> get user =>
      _firebaseAuth.authStateChanges().asyncMap((user) async {
        if (user != null) {
          // Получаем данные пользователя из Firestore
          DocumentSnapshot doc = await usersCollection.doc(user.uid).get();
          if (doc.exists) {
            return UserModel.fromJson(doc.data() as Map<String, dynamic>);
          }
        }
        return null; // Возвращаем null, если пользователь не вошел в систему или данные не найдены
      });

  // Метод для получения текущего аутентифицированного пользователя
  Future<UserModel?> getCurrentUser() async {
    User? firebaseUser =
        _firebaseAuth.currentUser; // Получаем текущего пользователя

    if (firebaseUser != null) {
      DocumentSnapshot doc = await usersCollection.doc(firebaseUser.uid).get();
      if (doc.exists) {
        return UserModel.fromJson(doc.data() as Map<String, dynamic>);
      }
    }
    return null; // Если пользователь не аутентифицирован или данные не найдены
  }

  // Метод для регистрации нового пользователя
  @override
  Future<UserModel> signUp(UserModel user, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      );

      // Обновляем ID пользователя после успешной регистрации
      user = user.copyWith(id: userCredential.user!.uid);

      await setUserData(user);

      return user;
    } catch (e) {
      log('Ошибка при регистрации: ${e.toString()}');
      throw Exception('Не удалось зарегистрироваться: ${e.toString()}');
    }
  }

  // Метод для входа существующего пользователя
  @override
  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      log('Ошибка при входе: ${e.toString()}');
      throw Exception('Не удалось войти: ${e.toString()}');
    }
  }

  // Метод для выхода текущего пользователя
  @override
  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      log('Ошибка при выходе: ${e.toString()}');
      throw Exception('Не удалось выйти: ${e.toString()}');
    }
  }

  // Метод для сброса пароля пользователя
  @override
  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      log('Ошибка при сбросе пароля: ${e.toString()}');
      throw Exception('Не удалось сбросить пароль: ${e.toString()}');
    }
  }

  // Метод для сохранения или обновления данных пользователя в Firestore
  @override
  Future<void> setUserData(UserModel user) async {
    try {
      await usersCollection.doc(user.id).set(user.toJson());
    } catch (e) {
      log('Ошибка при сохранении данных пользователя: ${e.toString()}');
      throw Exception(
          'Не удалось сохранить данные пользователя: ${e.toString()}');
    }
  }

  /// Method to save or update user data in Firestore
  Future<void> setUserDataddddd(UserModel user) async {
    try {
      await usersCollection
          .doc(user.id)
          .set(user.toJson(), SetOptions(merge: true));
    } catch (e) {
      print('Error saving user data: $e');
      throw Exception('Failed to save user data');
    }
  }

  // Метод для получения всех пользователей из Firestore
  @override
  Future<List<UserModel>> getAllUsers() async {
    try {
      QuerySnapshot snapshot = await usersCollection.get();

      return snapshot.docs.map((doc) {
        return UserModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      throw Exception('Ошибка при получении пользователей: ${e.toString()}');
    }
  }

  // Метод для получения преподавателей
  Future<List<UserModel>> getTeachersRep() async {
    try {
      QuerySnapshot snapshot =
          await usersCollection.where('role', isEqualTo: 'Преподаватель').get();
      return snapshot.docs
          .map((doc) => UserModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Не удалось получить преподавателей: ${e.toString()}');
    }
  }

  // Метод для получения лучших студентов
  Future<List<UserModel>> getBestStudentsRep() async {
    try {
      QuerySnapshot snapshot =
          await usersCollection.where('specialty', isEqualTo: '1').get();
      return snapshot.docs
          .map((doc) => UserModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Не удалось получить лучших студентов: ${e.toString()}');
    }
  }

  // Метод для получения Студенческого совета
  Future<List<UserModel>> getStudentCouncilRep() async {
    try {
      QuerySnapshot snapshot =
          await usersCollection.where('specialty', isEqualTo: '3').get();
      return snapshot.docs
          .map((doc) => UserModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Не удалось получить Студ. совет: ${e.toString()}');
    }
  }

  // Метод для получения активистов
  Future<List<UserModel>> getActivistsRep() async {
    try {
      QuerySnapshot snapshot =
          await usersCollection.where('specialty', isEqualTo: '2').get();
      return snapshot.docs
          .map((doc) => UserModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Не удалось получить Активисты: ${e.toString()}');
    }
  }

  // Метод для получения отчислений
  Future<List<UserModel>> getDeductionRep() async {
    try {
      QuerySnapshot snapshot =
          await usersCollection.where('specialty', isEqualTo: '4').get();
      return snapshot.docs
          .map((doc) => UserModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Не удалось получить отчисления: ${e.toString()}');
    }
  }

  // Метод для получения студентов по своей группе
  Future<List<UserModel>> getStudentsByGroupRep(String group) async {
    try {
      QuerySnapshot snapshot =
          await usersCollection.where('group', isEqualTo: group).get();
      return snapshot.docs
          .map((doc) => UserModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception(
          'Не удалось получить студентов по группе: ${e.toString()}');
    }
  }
}
