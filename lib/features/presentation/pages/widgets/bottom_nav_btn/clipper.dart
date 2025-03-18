import 'package:flutter/material.dart';

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    
    // Получаем ширину экрана
    double screenWidth = size.width;

    // Используем процентные соотношения для адаптивного позиционирования
    path.lineTo(screenWidth * 0.03, 0); // 3% от ширины
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width - screenWidth * 0.03, 0); // 3% от ширины

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
