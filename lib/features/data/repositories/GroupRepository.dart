import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/group_model.dart';
import '../models/subjects_model.dart';
import '../models/user_model.dart';

class GroupRepository {
  // Инициализация экземпляра Firestore для работы с базой данных
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Метод для получения всех групп
  Future<List<GroupModel>> getAllGroups() async {
    try {
      // Получаем все документы из коллекции 'groups'
      QuerySnapshot snapshot = await _firestore.collection('groups').get();
      // Преобразуем документы в список объектов GroupModel
      return snapshot.docs
          .map((doc) => GroupModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      // Если произошла ошибка, выбрасываем исключение с сообщением
      throw Exception('Не удалось получить группы: $e');
    }
  }

  // Метод для получения студентов по группе
  Future<List<UserModel>> getStudentsByGroupRep(String group) async {
    try {
      // Запрашиваем студентов из коллекции 'users', фильтруя по группе
      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .where('group', isEqualTo: group)
          .get();
      // Преобразуем документы в список объектов UserModel
      return snapshot.docs
          .map((doc) => UserModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      // Если произошла ошибка, выбрасываем исключение с сообщением
      throw Exception('Не удалось получить студентов по группе: $e');
    }
  }

  // Метод для сохранения предмета
  Future<void> saveSubject(SubjectsModel subject) async {
    try {
      // Добавляем новый предмет в коллекцию 'subjects'
      await _firestore.collection('subjects').add(subject.toJson());
    } catch (e) {
      // Если произошла ошибка, выбрасываем исключение с сообщением
      throw Exception('Ошибка при сохранении предмета: $e');
    }
  }

  // Метод для получения всех предметов для курса и группы
  Future<List<SubjectsModel>> getAllSubjectsForCourseAndGroup(
      String course, String groupName) async {
    try {
      // Запрашиваем предметы из коллекции 'subjects', фильтруя по курсу и группе
      QuerySnapshot snapshot = await _firestore
          .collection('subjects')
          .where('course', isEqualTo: course)
          .where('group', isEqualTo: groupName)
          .get();
      // Преобразуем документы в список объектов SubjectsModel
      return snapshot.docs
          .map((doc) =>
              SubjectsModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      // Если произошла ошибка, выбрасываем исключение с сообщением
      throw Exception('Ошибка при получении предметов: $e');
    }
  }

  // Метод для получения предметов по userId, курсу и названию предмета
  Future<SubjectsModel?> getSubjects(String userId, String course, String subjectName) async {
    try {
      // Запрашиваем предметы из коллекции 'subjects', фильтруя по userId, курсу и названию предмета
      QuerySnapshot snapshot = await _firestore
          .collection('subjects')
          .where('userId', isEqualTo: userId)
          .where('course', isEqualTo: course)
          .where('subjectName', isEqualTo: subjectName)
          .get();

      if (snapshot.docs.isNotEmpty) {
        // Если найдены документы, возвращаем первый найденный объект SubjectsModel
        return SubjectsModel.fromJson(snapshot.docs[0].data() as Map<String, dynamic>);
      }
      return null; // Если документов нет, возвращаем null
    } catch (e) {
      // Если произошла ошибка, выбрасываем исключение с сообщением
      throw Exception('Ошибка при получении предметов: $e');
    }
  }

  // Метод для сохранения оценок студента по предмету
  Future<void> saveGrades(String userId, GradesModel grades, String course,
      String group, String subjectName) async {
    
    String docId = '$userId-$subjectName'; // Уникальный идентификатор документа на основе userId и названия предмета
    DocumentReference subjectDoc = _firestore.collection('subjects').doc(docId);
    
    DocumentSnapshot snapshot = await subjectDoc.get();

    if (snapshot.exists) {
      // Если документ существует, обновляем оценки
      SubjectsModel subjectsModel =
          SubjectsModel.fromJson(snapshot.data() as Map<String, dynamic>);

      // Проверяем, есть ли уже оценки у студента
      if (subjectsModel.gradesUser.isNotEmpty) {
        // Обновляем существующую оценку (предполагается, что только одна оценка)
        subjectsModel.gradesUser[0] = grades; 
      } else {
        // Если оценок нет, добавляем новую оценку
        subjectsModel.gradesUser.add(grades);
      }

      // Сохраняем обновленные данные обратно в Firestore
      await subjectDoc.set(subjectsModel.toJson());
    } else {
      // Если документа нет, создаем новый документ с оценками студента
      SubjectsModel newSubjectsModel = SubjectsModel(
        course: course,
        group: group,
        userId: userId,
        subjectName: subjectName,
        gradesUser: [grades], // Инициализируем с новой оценкой
      );
      
      await subjectDoc.set(newSubjectsModel.toJson());
    }
  }
}