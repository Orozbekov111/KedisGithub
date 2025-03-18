import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/group_model.dart';

class ScheduleManager {
  final CollectionReference groupsCollection;

  ScheduleManager() : groupsCollection = FirebaseFirestore.instance.collection('groups');

   /// Получает все группы из Firestore
   Future<List<GroupModel>> getAllGroups() async {
     QuerySnapshot snapshot = await groupsCollection.get();
     return snapshot.docs.map((doc) => GroupModel.fromJson(doc.data() as Map<String, dynamic>)).toList();
   }

   /// Создает новую группу и сохраняет ее в Firestore
   Future<void> createGroup(String id, String groupName) async {
     final group = GroupModel(id: id, groupName: groupName, schedules: []);
     await groupsCollection.doc(id).set(group.toJson());
     print('Группа создана: $groupName');
   }

   /// Добавляет расписание для группы и обновляет Firestore
   Future<void> addSchedule(String groupId, String dayOfWeek, List<Lesson> lessons) async {
     final schedule = ScheduleModel(dayOfWeek: dayOfWeek, lessons: lessons);
     
     DocumentSnapshot doc = await groupsCollection.doc(groupId).get();
     
     if (doc.exists) {
       GroupModel group = GroupModel.fromJson(doc.data() as Map<String, dynamic>);
       group.schedules.add(schedule);
       
       await groupsCollection.doc(groupId).update({'schedules': group.schedules.map((s) => s.toJson()).toList()});
       print('Расписание добавлено для группы ${group.groupName} на $dayOfWeek');
     } else {
       print('Группа не найдена');
     }
   }

   /// Получает расписание группы из Firestore по имени группы
   Future<List<ScheduleModel>> getScheduleByGroupName(String groupName) async {
     QuerySnapshot snapshot = await groupsCollection.where('groupName', isEqualTo: groupName).get();

     if (snapshot.docs.isNotEmpty) {
       List<ScheduleModel> schedules = [];
       for (var doc in snapshot.docs) {
         GroupModel group = GroupModel.fromJson(doc.data() as Map<String, dynamic>);
         schedules.addAll(group.schedules);
       }
       return schedules;
     }
     
     return []; // Возвращаем пустой список, если группа не найдена
   }

   /// Получает расписание группы из Firestore по идентификатору группы
   Future<List<ScheduleModel>> getSchedule(String groupId) async {
     DocumentSnapshot doc = await groupsCollection.doc(groupId).get();
     if (doc.exists) {
       GroupModel group = GroupModel.fromJson(doc.data() as Map<String, dynamic>);
       return group.schedules; // Возвращаем расписание
     }
     return []; // Возвращаем пустой список, если группа не найдена
   }
}