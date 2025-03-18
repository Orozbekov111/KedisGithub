import 'package:flutter/material.dart';
import '../../../../data/models/user_model.dart';
import '../../../../data/repositories/firebase_user_repository.dart';
import '../../widgets/app_bar_widget.dart';
import '../../widgets/card_user_widget.dart';
import 'person_detail_screen/person_detail_screen.dart';

class DeductionScreen extends StatefulWidget {
  const DeductionScreen({super.key});

  @override
  State<DeductionScreen> createState() => _DeductionScreenState();
}

class _DeductionScreenState extends State<DeductionScreen> {
  late FirebaseUserRepository firebaseUserRepository;
  late Future<List<UserModel>> futureDeduction;

  @override
  void initState() {
    super.initState();
    firebaseUserRepository = FirebaseUserRepository();
    futureDeduction = getDeduction();
  }

  Future<List<UserModel>> getDeduction() async {
    try {
      return await firebaseUserRepository.getDeductionRep();
    } catch (e) {
      throw Exception('Не удалось получить студ совет');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70.0), // Высота AppBar
        child: AppBarWidget(
          nameAppBar: 'Студенты на отчисление',
        ),
      ),
      body: FutureBuilder<List<UserModel>>(
        future: futureDeduction,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Нет доступных студентов'));
          }

          List<UserModel> decorations = snapshot.data!;

          return ListView.builder(
            itemCount: decorations.length,
            itemBuilder: (context, index) {
              UserModel decoration = decorations[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PersonDetailScreen.fromUserModel(decoration),
                    ),
                  );
                },
                child: CardUserWidget(
                  user: decoration,
                  title: decoration.fullName,
                  subtitle: decoration.group,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
