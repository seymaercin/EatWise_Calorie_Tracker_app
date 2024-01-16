import 'package:eatwise_calorie_tracker/view/common/common_show_dialog.dart';
import 'package:eatwise_calorie_tracker/view/forgot_password_page.dart';
import 'package:eatwise_calorie_tracker/view/main_layout_page.dart';
import 'package:eatwise_calorie_tracker/view/register_page.dart';
import 'package:eatwise_calorie_tracker/view_model/forgot_password_view_model.dart';
import 'package:eatwise_calorie_tracker/view_model/main_layout_view_model.dart';
import 'package:eatwise_calorie_tracker/view_model/register_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginViewModel with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void login(BuildContext context, email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      _openMainPage(context);
    } on FirebaseAuthException catch (e) {
     CommonShowDialog.myShowDialog(context, e.message.toString());
    }
  }

  void openRegisterPage(BuildContext context) {
    MaterialPageRoute pageRoute = MaterialPageRoute(
      builder: (context) => ChangeNotifierProvider(
        create: (context) => RegisterViewModel(),
        child: RegisterPage(),
      ),
    );
    Navigator.pushReplacement(context, pageRoute);
  }

  void _openMainPage(BuildContext context) {
    MaterialPageRoute pageRoute = MaterialPageRoute(
      builder: (context) => ChangeNotifierProvider(
        create: (context) => MainLayoutViewModel(),
        child: const MainLayoutPage(),
      ),
    );
    Navigator.pushReplacement(context, pageRoute);
  }

  void goToForgotPasswordPage(BuildContext context) {
    MaterialPageRoute pageRoute = MaterialPageRoute(
      builder: (context) => ChangeNotifierProvider(
        create: (context) => ForgotPasswordViewModel(),
        child: ForgotPasswordPage(),
      ),
    );
    Navigator.push(context, pageRoute);
  }
}
