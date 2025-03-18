import 'package:flutter/material.dart';

import '../../../../../data/models/user_model.dart';
import '../../../widgets/app_bar_widget.dart';

class PersonDetailScreen extends StatelessWidget {
  const PersonDetailScreen({
    super.key,
    required this.user,
    required this.name,
    required this.role,
    required this.group,
    required this.profession,
    required this.email,
    required this.phone,
  });

  final UserModel user;
  final String name;
  final String role;
  final String group;
  final String profession;
  final String email;
  final String phone;

  // Factory constructor for creating an instance from UserModel
  factory PersonDetailScreen.fromUserModel(UserModel user) {
    return PersonDetailScreen(
      user: user,
      name: user.fullName,
      role: user.role,
      group: user.group,
      profession: user.profession,
      email: user.email, // Assuming email is a property of UserModel
      phone: user.phone, // Assuming phone is a property of UserModel
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70.0), // Высота AppBar
        child: AppBarWidget(
          nameAppBar: 'Пользователь',
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),

                // Profile Picture
                CircleAvatar(
                  backgroundImage: user.picture != null &&
                          user.picture!.isNotEmpty
                      ? NetworkImage(user.picture!)
                      : const NetworkImage(
                          'https://avatars.mds.yandex.net/i?id=667f5c28b26380ca30c3317ee7fa8369_l-5279191-images-thumbs&n=13'),
                  radius: 65,
                ),

                const SizedBox(height: 10),
                Text(
                  name,
                  style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF004D40)),
                ),
                Text(
                  role,
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                ),
                const SizedBox(height: 20),

                // Student Details Container
                Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.05),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(blurRadius: 10, color: Colors.black26)
                      ],
                      gradient: const LinearGradient(
                        colors: [Color(0xFF00796B), Color(0xFF004D40)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionTitle("Данные о Студенте"),
                        _buildInfoRow("ФИО:", name),
                        if (role == 'Студент') ...[
                          _buildInfoRow("Группа:", group),
                        ],
                        _buildInfoRow("Профессия:", profession),
                        const SizedBox(height: 20),
                        _buildSectionTitle("Персональные данные"),
                        _buildInfoRow("Email:", email),
                        _buildInfoRow("Телефон:", phone),
                      ],
                    )),

                const SizedBox(height: 250), // Extra space at the bottom
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(
                  fontWeight: FontWeight.w500, color: Colors.white70)),
          Flexible(
              child:
                  Text(value, style: const TextStyle(color: Colors.white70))),
        ],
      ),
    );
  }
}
