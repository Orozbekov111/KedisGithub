import 'package:flutter/material.dart';

double animatedPositionedLeftValue(BuildContext context, int currentIndex) {
  // Получаем ширину экрана
  double screenWidth = MediaQuery.of(context).size.width;

  // Определяем коэффициенты для адаптивного позиционирования
  switch (currentIndex) {
    case 0:
      return screenWidth * 0.055; // 5.5%
    case 1:
      return screenWidth * 0.225; // 22.5%
    case 2:
      return screenWidth * 0.395; // 39.5%
    case 3:
      return screenWidth * 0.565; // 56.5%
    case 4:
      return screenWidth * 0.735; // 73.5%
    default:
      return 0;
  }
}


final List<Color> gradient = [
  Colors.green.withOpacity(0.8),
  Colors.green.withOpacity(0.5),
  Colors.transparent
];
