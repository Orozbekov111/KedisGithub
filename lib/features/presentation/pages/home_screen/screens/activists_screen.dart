import 'package:flutter/material.dart';
import '../../../../data/models/user_model.dart';
import '../../../../data/repositories/firebase_user_repository.dart';
import '../../widgets/app_bar_widget.dart';
import '../../widgets/card_user_widget.dart';
import 'person_detail_screen/person_detail_screen.dart';

class ActivistsScreen extends StatefulWidget {
  const ActivistsScreen({super.key});

  @override
  State<ActivistsScreen> createState() => _ActivistsScreenState();
}

class _ActivistsScreenState extends State<ActivistsScreen> {
  late FirebaseUserRepository firebaseUserRepository;
  late Future<List<UserModel>> futureActivists;

  @override
  void initState() {
    super.initState();
    firebaseUserRepository = FirebaseUserRepository();
    futureActivists = getActivistsCouncil();
  }

  Future<List<UserModel>> getActivistsCouncil() async {
    try {
      return await firebaseUserRepository.getActivistsRep();
    } catch (e) {
      throw Exception('Не удалось получить : ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70.0), // Высота AppBar
        child: AppBarWidget(
          nameAppBar: 'Активисты',
        ),
      ),
      body: FutureBuilder<List<UserModel>>(
        future: futureActivists,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Нет доступных активистов'));
          }

          List<UserModel> activists = snapshot.data!;

          return ListView.builder(
            itemCount: activists.length,
            itemBuilder: (context, index) {
              UserModel activ = activists[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PersonDetailScreen.fromUserModel(activ),
                    ),
                  );
                },
                child: CardUserWidget(
                  user: activ,
                  title: activ.fullName,
                  subtitle: activ.group,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
