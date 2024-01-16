import 'package:flutter/material.dart';
class CommonShowDialog {
  static void myShowDialog(BuildContext context, String mesaj) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(mesaj),
      ),
    );
  }
}