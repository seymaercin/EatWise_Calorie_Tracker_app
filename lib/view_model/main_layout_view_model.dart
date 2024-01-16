import 'package:eatwise_calorie_tracker/view/login_page.dart';
import 'package:eatwise_calorie_tracker/view/main_page.dart';
import 'package:eatwise_calorie_tracker/view/profile_page.dart';
import 'package:eatwise_calorie_tracker/view_model/login_view_model.dart';
import 'package:eatwise_calorie_tracker/view_model/main_view_model.dart';
import 'package:eatwise_calorie_tracker/view_model/profile_view_model.dart';
import 'package:eatwise_calorie_tracker/view_model/total_calorie_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainLayoutViewModel with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  int _selectedIndex = 0;

  List<Widget> pages = [
    ChangeNotifierProvider(
      create: (context) => MainViewModel(),
      child: const MainPage(),
    ),
    ChangeNotifierProvider(
      create: (context) => ProfileViewModel(),
      child: ProfilePage(),
    ),
  ];

  int get selectedIndex => _selectedIndex;

  void navBarOnTap(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void goLoginPage(BuildContext context) {
    MaterialPageRoute pageRoute = MaterialPageRoute(
      builder: (context) => ChangeNotifierProvider(
        create: (context) => LoginViewModel(),
        child: LoginPage(),
      ),
    );
    Navigator.pushAndRemoveUntil(
        context, pageRoute, (Route<dynamic> route) => false);
  }

  void signOut(BuildContext context) async {
    await _auth.signOut();
    TotalCalorieProvider viewModel = Provider.of(context, listen: false);
    viewModel.clear();
    goLoginPage(context);
  }
}
