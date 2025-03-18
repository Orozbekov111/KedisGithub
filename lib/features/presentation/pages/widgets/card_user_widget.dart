import 'package:flutter/material.dart';

import '../../../data/models/user_model.dart';

class CardUserWidget extends StatelessWidget {
  const CardUserWidget({
    super.key,
    required this.user,
    required this.title,
    required this.subtitle,
  });

  final UserModel user;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF00796B),
                Color(0xFF004D40),
              ], // Градиентный фон
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15), // Закругление углов
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
            leading: CircleAvatar(
              backgroundImage: user.picture != null && user.picture!.isNotEmpty
                  ? NetworkImage(user.picture!) // Use user's photo if available
                  : const NetworkImage(
                      'https://avatars.mds.yandex.net/i?id=667f5c28b26380ca30c3317ee7fa8369_l-5279191-images-thumbs&n=13'),
              radius: 30,
            ),
            

            title: Text(title,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)), // Use passed title
            subtitle: Text(
              subtitle,
              style: const TextStyle(color: Colors.white),
            ), // Use passed subtitle
            trailing: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Icon(Icons.arrow_forward_ios, color: Colors.white),
            ),
          )),
    );
  }
}
