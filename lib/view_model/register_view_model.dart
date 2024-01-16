import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatwise_calorie_tracker/view/common/common_show_dialog.dart';
import 'package:eatwise_calorie_tracker/view/login_page.dart';
import 'package:eatwise_calorie_tracker/view/main_layout_page.dart';
import 'package:eatwise_calorie_tracker/view_model/login_view_model.dart';
import 'package:eatwise_calorie_tracker/view_model/main_layout_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterViewModel with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  

  void register(
    BuildContext context,
    String email,
    String password,
    String userName,
    String kilo,
    String boy,
    String yas,
  ) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = credential.user;
      if (user != null) {
        await _firestore.collection("users").doc(user.uid).set({
          "email": email,
          "password": password,
          "userName": userName,
          "kilo": kilo,
          "boy": boy,
          "yas": yas,
        });
        _openMainPage(context);
      }
    } on FirebaseAuthException catch (e) {
      CommonShowDialog.myShowDialog(context, e.message.toString());
    
    }
  }

  void openLoginPage(BuildContext context) {
    MaterialPageRoute pageRoute = MaterialPageRoute(
      builder: (context) => ChangeNotifierProvider(
        create: (context) => LoginViewModel(),
        child: LoginPage(),
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
}
