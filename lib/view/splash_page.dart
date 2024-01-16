import 'package:eatwise_calorie_tracker/view_model/splash_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    SplashViewModel viewModel =
        Provider.of<SplashViewModel>(context, listen: false);
    viewModel.redirect(context);

    return Scaffold(
      backgroundColor: const Color(0xFF005174),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo

              Image.asset(
                "assets/eatwiselogo.png",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
