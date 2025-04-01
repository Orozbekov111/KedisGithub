import 'package:flutter/material.dart';

Widget buildInfoRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      vertical: 8,
    ), // Vertical spacing between rows
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        Flexible(
          child: Text(value, style: const TextStyle(color: Colors.black54)),
        ),
      ],
    ),
  );
}
