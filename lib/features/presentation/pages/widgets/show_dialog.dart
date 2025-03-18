import 'package:flutter/material.dart';

void ShowDialog(BuildContext context,
    {required String title, required String content}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(
          child: Text(title),
        ),
        content: SingleChildScrollView(
          // Позволяет прокручивать содержимое, если оно слишком длинное
          child: ConstrainedBox(
            constraints: const BoxConstraints(
                maxWidth: 700), // Ограничение максимальной ширины
            child: Text(
              content,
              style: const TextStyle(
                fontSize: 16, // Размер шрифта
                height:
                    1.2, // Высота строки (уменьшите это значение для уменьшения высоты)
              ),
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Закрыть диалог
            },
            child:const  Text('Закрыть'),
          ),
        ],
      );
    },
  );
}
