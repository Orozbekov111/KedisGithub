import 'package:flutter/material.dart';
import '../../../../data/models/user_model.dart';
import '../../../../data/repositories/firebase_user_repository.dart';
import '../../widgets/app_bar_widget.dart';
import '../../widgets/card_user_widget.dart';
import 'person_detail_screen/person_detail_screen.dart';

class AllTeacherScreen extends StatefulWidget {
  const AllTeacherScreen({super.key});

  @override
  State<AllTeacherScreen> createState() => _AllTeacherScreenState();
}

class _AllTeacherScreenState extends State<AllTeacherScreen> {
  late FirebaseUserRepository firebaseUserRepository;
  late Future<List<UserModel>> futureTeachers;

  @override
  void initState() {
    super.initState();
    firebaseUserRepository =
        FirebaseUserRepository(); // Инициализация репозитория
    futureTeachers = getTeachers(); // Получение списка преподавателей
  }

  Future<List<UserModel>> getTeachers() async {
    try {
      return await firebaseUserRepository.getTeachersRep();
    } catch (e) {
      throw Exception('Не удалось получить преподавателей: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70.0), // Высота AppBar
        child: AppBarWidget(
          nameAppBar: 'Преподаватели',
        ),
      ),
      body: FutureBuilder<List<UserModel>>(
        future: futureTeachers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Нет доступных преподавателей'));
          }

          List<UserModel> teachers = snapshot.data!;

          return ListView.builder(
            itemCount: teachers.length,
            itemBuilder: (context, index) {
              UserModel teacher = teachers[index];
              return GestureDetector(
                onTap: () {
                 Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PersonDetailScreen.fromUserModel(teacher),
                    ),
                  );
                },
                child: CardUserWidget(
                  user: teacher,
                  title: teacher.fullName,
                  subtitle: teacher.profession,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
