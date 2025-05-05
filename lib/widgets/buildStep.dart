import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildStep(String text, {bool isValid = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          isValid ? Icons.check_circle : Icons.error_outline,
          size: 16,
          color: isValid ? Colors.green : Colors.red,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: isValid ? Colors.grey[600] : Colors.red,
            ),
          ),
        ),
      ],
    ),
  );
}