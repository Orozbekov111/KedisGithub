import 'package:flutter/material.dart';
import '../../../../data/models/user_model.dart';
import '../../../../data/repositories/firebase_user_repository.dart';
import '../../widgets/app_bar_widget.dart';
import '../../widgets/card_user_widget.dart';
import 'person_detail_screen/person_detail_screen.dart';

class MyGroupScreen extends StatefulWidget {
  const MyGroupScreen({super.key});

  @override
  State<MyGroupScreen> createState() => _MyGroupScreenState();
}

class _MyGroupScreenState extends State<MyGroupScreen> {
  late FirebaseUserRepository firebaseUserRepository;
  late Future<List<UserModel>> futureMyGroup;

  @override
  void initState() {
    super.initState();
    firebaseUserRepository = FirebaseUserRepository();
    futureMyGroup = getStudentsByGroup();
  }

  Future<List<UserModel>> getStudentsByGroup() async {
    try {
      UserModel? currentUser = await firebaseUserRepository.getCurrentUser();
      if (currentUser != null) {
        return await firebaseUserRepository
            .getStudentsByGroupRep(currentUser.group);
      } else {
        throw Exception('Не удалось получить текущего пользователя');
      }
    } catch (e) {
      throw Exception('Не удалось получить Вашу группу: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70.0), // Высота AppBar
        child: AppBarWidget(
          nameAppBar: 'Моя группа',
        ),
      ),
      body: FutureBuilder<List<UserModel>>(
        future: futureMyGroup,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Нет доступных студентов'));
          }

          List<UserModel> Students = snapshot.data!;

          return ListView.builder(
            itemCount: Students.length,
            itemBuilder: (context, index) {
              UserModel student = Students[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PersonDetailScreen.fromUserModel(student),
                    ),
                  );
                },
                child: CardUserWidget(
                  user: student,
                  title: student.fullName,
                  subtitle: student.group,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
