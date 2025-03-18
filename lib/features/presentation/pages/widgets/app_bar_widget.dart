import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  final nameAppBar;

  const AppBarWidget({
    required this.nameAppBar,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF00796B), Color(0xFF004D40)], // Градиентный фон
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30.0)), // Закругленные углы
        boxShadow: [
          BoxShadow(
            color: Colors.black26, // Цвет тени
            blurRadius: 10.0, // Размытие тени
            offset: Offset(0, 4), // Смещение тени
          ),
        ],
      ),
      child: AppBar(          
        title: Text(
          nameAppBar,
          style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent, // Делаем фон прозрачным для градиента
        elevation: 0, // Убираем стандартную тень
      ),
    );
  }
}