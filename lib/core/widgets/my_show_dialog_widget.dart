import 'package:flutter/material.dart';



Future<void> MyShowDialogWidget(
  BuildContext context, {
  required String title,
  required String content,
  bool isSuccess = false, // Новый параметр для определения типа сообщения
}) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(
          child: Text(
            title,
            style: TextStyle(
              color: isSuccess ? Colors.green : Colors.red, // Цвет заголовка в зависимости от успеха
            ),
          ),
        ),
        icon: Icon(
          isSuccess ? Icons.check_circle : Icons.error,
          color: isSuccess ? Colors.green : Colors.red,
          size: 48,
        ),
        content: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Text(
              content,
              style: const TextStyle(
                fontSize: 16,
                height: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        actions: <Widget>[
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Закрыть'),
            ),
          ),
        ],
      );
    },
  );
}