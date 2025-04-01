import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kedis/features2/time/domain/entities/view_schedule_entity.dart';
import 'package:kedis/features2/time/domain/entities/view_user_entity.dart';

class ViewScheduleRemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  ViewScheduleRemoteDataSource({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  Future<AppUser> getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('User not authenticated');

      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (!doc.exists) throw Exception('User document not found');

      final userData = doc.data()!;
      return AppUser(
        id: user.uid,
        email: user.email ?? '',
        name: userData['fullName'] ?? userData['name'] ?? '',
        groupId: userData['group']?.toString() ?? '',
        role: userData['role']?.toString() ?? 'student',
      );
    } catch (e) {
      throw Exception('Failed to get user: ${e.toString()}');
    }
  }

  Future<Schedule> getCurrentUserSchedule() async {
    try {
      final user = await getCurrentUser();
      if (user.groupId.isEmpty) {
        throw Exception('User does not belong to any group');
      }
      
      // Get the group document to get the group name
      final groupDoc = await _firestore.collection('groups').doc(user.groupId).get();
      final groupName = groupDoc.data()?['name']?.toString() ?? 'Unnamed Group';
      
      return await getGroupSchedule(user.groupId, groupName);
    } catch (e) {
      throw Exception('Failed to get user schedule: ${e.toString()}');
    }
  }

  Future<Schedule> getGroupSchedule(String groupId, String groupName) async {
    try {
      if (groupId.isEmpty) {
        throw Exception('Group ID cannot be empty');
      }

      // Verify group exists
      final groupDoc = await _firestore.collection('groups').doc(groupId).get();
      if (!groupDoc.exists) {
        throw Exception('Group with ID "$groupId" not found');
      }

      // Get all schedule days
      final daysSnapshot = await _firestore
          .collection('groups')
          .doc(groupId)
          .collection('days')
          .get();

      final daySchedules = <String, DaySchedule>{};
      
      for (final doc in daysSnapshot.docs) {
        final data = doc.data();
        final lessonsList = data['lessons'] as List<dynamic>? ?? [];
        
        final lessons = lessonsList.map((lesson) {
          final lessonMap = lesson as Map<String, dynamic>;
          return Lesson(
            subject: lessonMap['subject']?.toString() ?? 'Not specified',
            time: lessonMap['time']?.toString() ?? 'Not specified',
            teacher: lessonMap['teacherName']?.toString() ?? 
                    lessonMap['teacher']?.toString() ?? 'Not specified',
            classroom: lessonMap['classroom']?.toString() ?? 'Not specified',
          );
        }).toList();

        daySchedules[doc.id] = DaySchedule(
          dayName: doc.id,
          lessons: lessons,
        );
      }

      return Schedule(
        groupId: groupId,
        groupName: groupName,
        days: daySchedules,
      );
    } catch (e) {
      throw Exception('Failed to get schedule for group "$groupId": ${e.toString()}');
    }
  }

  Future<List<Map<String, String>>> getAllGroups() async {
    try {
      final snapshot = await _firestore.collection('groups').get();
      return snapshot.docs.map((doc) => {
        'id': doc.id,
        'name': doc.data()['name']?.toString() ?? 'Unnamed Group',
      }).toList();
    } catch (e) {
      throw Exception('Failed to get groups list: ${e.toString()}');
    }
  }
}