import 'package:flutter/material.dart';
import '../../../../data/models/user_model.dart';
import '../../../../data/repositories/firebase_user_repository.dart';
import '../../widgets/app_bar_widget.dart';
import '../../widgets/card_user_widget.dart';
import 'person_detail_screen/person_detail_screen.dart';

class StudentCouncilScreen extends StatefulWidget {
  const StudentCouncilScreen({super.key});

  @override
  State<StudentCouncilScreen> createState() => _StudentCouncilScreenState();
}

class _StudentCouncilScreenState extends State<StudentCouncilScreen> {
  late FirebaseUserRepository firebaseUserRepository;
  late Future<List<UserModel>> studentCouncil;

  @override
  void initState() {
    super.initState();
    firebaseUserRepository = FirebaseUserRepository();
    studentCouncil = getStudentCouncil();
  }

  Future<List<UserModel>> getStudentCouncil() async {
    try {
      return await firebaseUserRepository.getStudentCouncilRep();
    } catch (e) {
      throw Exception('Не удалось получить Студ. совет: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70.0), // Высота AppBar
        child: AppBarWidget(
          nameAppBar: 'Студ. совет',
        ),
      ),
      body: FutureBuilder<List<UserModel>>(
        future: studentCouncil,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Нет доступных студентов'));
          }

          List<UserModel> stCouncil = snapshot.data!;

          return ListView.builder(
            itemCount: stCouncil.length,
            itemBuilder: (context, index) {
              UserModel council = stCouncil[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PersonDetailScreen.fromUserModel(council),
                    ),
                  );
                },
                child: CardUserWidget(
                  user: council,
                  title: council.fullName,
                  subtitle: council.group,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
