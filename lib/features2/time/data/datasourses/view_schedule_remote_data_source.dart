import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kedis/features2/time/domain/entities/view_lesson_entity.dart';
import 'package:kedis/features2/time/domain/entities/view_schedule_entity.dart';

class ViewScheduleRemoteDataSource {
 
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<ViewScheduleEntity> getSchedule() async {
    final user = auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    final userDoc = await firestore.collection('users').doc(user.uid).get();
    if (!userDoc.exists) throw Exception('User document not found');

    final userData = userDoc.data() as Map<String, dynamic>;
    final userGroupName = userData['group'] as String?;
    if (userGroupName == null || userGroupName.isEmpty) {
      throw Exception('User has no group assigned');
    }

    final groupsQuery = await firestore.collection('groups')
        .where('name', isEqualTo: userGroupName)
        .limit(1)
        .get();

    if (groupsQuery.docs.isEmpty) {
      throw Exception('Group "$userGroupName" not found');
    }

    final groupDoc = groupsQuery.docs.first;
    final groupName = groupDoc.data()['name'] as String? ?? groupDoc.id;

    final daysSnapshot = await firestore
        .collection('groups')
        .doc(groupDoc.id)
        .collection('days')
        .get();

    final dayLessons = <String, List<ViewLessonEntity>>{};
    
    for (final dayDoc in daysSnapshot.docs) {
      final dayData = dayDoc.data();
      final lessons = List<Map<String, dynamic>>.from(dayData['lessons'] ?? []);
      dayLessons[dayDoc.id] = lessons.map((l) => ViewLessonEntity.fromMap(l)).toList();
    }

    return ViewScheduleEntity(
      groupId: groupDoc.id,
      groupName: groupName,
      dayLessons: dayLessons,
    );
  }
}