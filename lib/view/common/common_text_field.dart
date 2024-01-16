import 'package:flutter/material.dart';

class CommonTextFiled extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final String label;
  final TextInputType keyboardType;
   CommonTextFiled({
    super.key,
    required this.controller,
    required this.obscureText,
    required this.label,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(8.0),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Lütfen alanı boş bırakmayın";
          }
          return null;
        },
        obscureText: obscureText,
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          label: Text(label),
          focusedBorder: OutlineInputBorder(
            borderSide:  BorderSide(
              color: Color(
                0xFF007B9B,
              ),
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:  BorderSide(
              color: Color(
                0xFF007B9B,
              ),
            ),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
