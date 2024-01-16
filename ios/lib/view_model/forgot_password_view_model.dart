import 'package:eatwise_calorie_tracker/view/common/common_show_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordViewModel with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void resetPassword(BuildContext context, String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      CommonShowDialog.myShowDialog(
        context,
        "Şifrenizi sıfırlama bağlantısı email adresinize gönderildi. Lütfen kontrol ediniz",
      );
    } on FirebaseAuthException catch (e) {
      CommonShowDialog.myShowDialog(context, e.message.toString());
    }
  }

  void goBackLoginPage(BuildContext context) {
    Navigator.pop(context);
  }
}
