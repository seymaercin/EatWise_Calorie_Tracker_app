import 'package:eatwise_calorie_tracker/firebase_options.dart';
import 'package:eatwise_calorie_tracker/view/splash_page.dart';
import 'package:eatwise_calorie_tracker/view_model/splash_view_model.dart';
import 'package:eatwise_calorie_tracker/view_model/total_calorie_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TotalCalorieProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ChangeNotifierProvider(
          create: (context) => SplashViewModel(),
          child: const SplashPage(),
        ),
      ),
    );
  }
}
