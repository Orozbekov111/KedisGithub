import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../data/models/user_model.dart';
import '../../../../../data/repositories/firebase_user_repository.dart';
import '../../../widgets/app_bar_widget.dart';
import '../../../widgets/card_user_widget.dart';
import 'user_edit_screen.dart';

class UserListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70.0), // Высота AppBar
        child: AppBarWidget(
          nameAppBar: 'Список пользователей',
        ),
      ),
      body: FutureBuilder<List<UserModel>>(
        future: _fetchUsers(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Ошибка: ${snapshot.error}',
                    style: const TextStyle(color: Colors.red)));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
                child:
                    Text('Нет пользователей', style: TextStyle(fontSize: 18)));
          }

          final users = snapshot.data!;
          return Container(
            color: Colors.grey[300],
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserEditScreen(user: user)),
                    );
                  },
                  child: CardUserWidget(
                    user: user,
                    title: user.fullName,
                    subtitle: user.role,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Future<List<UserModel>> _fetchUsers(BuildContext context) async {
    final userRepository =
        Provider.of<FirebaseUserRepository>(context, listen: false);
    return await userRepository.getAllUsers();
  }
}
