import 'package:flutter/material.dart';

class MyConfirmationDialogWidget extends StatelessWidget {
  final String title;
  final String message;
  final String confirmButtonText;
  final String cancelButtonText;
  final Color confirmButtonColor;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  final bool popAfterConfirm;

  const MyConfirmationDialogWidget({
    super.key,
    required this.title,
    required this.message,
    required this.confirmButtonText,
    this.cancelButtonText = 'Отмена',
    this.confirmButtonColor = Colors.red,
    required this.onConfirm,
    this.onCancel,
    this.popAfterConfirm = true,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            onCancel?.call();
            Navigator.pop(context);
          },
          child: Text(cancelButtonText),
        ),
        TextButton(
          onPressed: () {
            onConfirm();
            if (popAfterConfirm) {
              Navigator.pop(context);
            }
          },
          child: Text(
            confirmButtonText,
            style: TextStyle(color: confirmButtonColor),
          ),
        ),
      ],
    );
  }
}