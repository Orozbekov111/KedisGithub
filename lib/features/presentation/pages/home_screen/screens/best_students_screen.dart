import 'package:flutter/material.dart';
import '../../../../data/models/user_model.dart';
import '../../../../data/repositories/firebase_user_repository.dart';
import '../../widgets/app_bar_widget.dart';
import '../../widgets/card_user_widget.dart';
import 'person_detail_screen/person_detail_screen.dart';

class BestStudentsScreen extends StatefulWidget {
  const BestStudentsScreen({super.key});

  @override
  State<BestStudentsScreen> createState() => _BestStudentsScreenState();
}

class _BestStudentsScreenState extends State<BestStudentsScreen> {
  late FirebaseUserRepository firebaseUserRepository;
  late Future<List<UserModel>> futureBestStudents;

  @override
  void initState() {
    super.initState();
    firebaseUserRepository = FirebaseUserRepository();
    futureBestStudents = getBestStudents();
  }

  Future<List<UserModel>> getBestStudents() async {
    try {
      return await firebaseUserRepository.getBestStudentsRep();
    } catch (e) {
      throw Exception('Не удалось получить студентов: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70.0), // Высота AppBar
        child: AppBarWidget(
          nameAppBar: 'Лучшие студенты',
        ),
      ),
      body: FutureBuilder<List<UserModel>>(
        future: futureBestStudents,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Нет доступных студентов'));
          }

          List<UserModel> bestStudents = snapshot.data!;

          return ListView.builder(
            itemCount: bestStudents.length,
            itemBuilder: (context, index) {
              UserModel student = bestStudents[index];
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
