import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kedis/features2/menu/create_a_schedule/domain/entities/schedule_entity.dart';

class CreateScheduleFirebaseDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addSchedule(ScheduleEntity schedule) async {
    try {
      // Добавляем расписание в подколлекцию days документа группы
      await _firestore
          .collection('groups')
          .doc(schedule.groupId)
          .collection('days')
          .doc(schedule.dayOfWeek.toLowerCase()) // Например, 'monday'
          .set({
        'lessons': schedule.lessons.map((lesson) => {
              'subject': lesson.subject,
              'time': lesson.time,
              'teacherName': lesson.teacherName,
              'classroom': lesson.classroom,
            }).toList(),
        'lastUpdated': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to add schedule: ${e.toString()}');
    }
  }

  Future<void> createGroup(String groupId, String groupName) async {
    try {
      // Создаем документ группы (без подколлекции days, она создастся автоматически)
      await _firestore.collection('groups').doc(groupId).set({
        'name': groupName,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to create group: ${e.toString()}');
    }
  }
}