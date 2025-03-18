import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback pressed; // Callback для нажатия кнопки
  final String text; // Текст на кнопке

  const ButtonWidget({
    required this.text,
    required this.pressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.08,
          decoration: BoxDecoration(
            gradient:const  LinearGradient(
              colors: [Color(0xFF00796B), Color(0xFF004D40)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow:const  [
              BoxShadow(
                color: Colors.grey, // Цвет тени
                spreadRadius: 1, // Расширение тени
                blurRadius: 3, // Размытие тени
                offset: Offset(0, 2), // Смещение тени по оси X и Y
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: pressed,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.transparent,
              padding:
                  EdgeInsets.symmetric(horizontal: 40), // Цвет текста на кнопке
              shadowColor: Colors.transparent, // Убираем тень кнопки
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30), // Радиус границы кнопки
              ),
            ), // Обработчик нажатия
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18, // Размер шрифта для лучшей читаемости
              ),
            ),
          ),
        ),
      ),
    );
  }
}
