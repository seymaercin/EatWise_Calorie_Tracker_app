import 'package:eatwise_calorie_tracker/view/login_page.dart';
import 'package:eatwise_calorie_tracker/view/main_layout_page.dart';
import 'package:eatwise_calorie_tracker/view_model/login_view_model.dart';
import 'package:eatwise_calorie_tracker/view_model/main_layout_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashViewModel with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void redirect(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(seconds: 2), () {
        checkIsLoggedIn(context);
      });
    });
  }

  void checkIsLoggedIn(BuildContext context) {
    String? userId = _auth.currentUser?.uid;

    if (userId != null) {
      goToMainPage(context);
    } else {
      goToLoginPage(context);
    }
  }

  void goToLoginPage(BuildContext context) {
    MaterialPageRoute pageRoute = MaterialPageRoute(
      builder: (context) => ChangeNotifierProvider(
        create: (context) => LoginViewModel(),
        child: LoginPage(),
      ),
    );
    Navigator.pushReplacement(context, pageRoute);
  }

  void goToMainPage(BuildContext context) {
    MaterialPageRoute pageRoute = MaterialPageRoute(
      builder: (context) => ChangeNotifierProvider(
        create: (context) => MainLayoutViewModel(),
        child: const MainLayoutPage(),
      ),
    );
    Navigator.pushReplacement(context, pageRoute);
  }
}
