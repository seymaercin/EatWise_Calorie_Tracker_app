import 'package:eatwise_calorie_tracker/view/common/common_text_field.dart';
import 'package:eatwise_calorie_tracker/view_model/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginPage({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Image.asset(
                    "assets/eatwise.png",
                    width: 270,
                  ),
                  CommonTextFiled(
                    controller: _emailController,
                    obscureText: false,
                    label: "Email",
                    keyboardType: TextInputType.emailAddress,
                  ),
                  CommonTextFiled(
                    controller: _passwordController,
                    obscureText: true,
                    label: "Şifre",
                    keyboardType: TextInputType.multiline,
                  ),
                  _buildForgotPassword(context),
                  _buildLogInButton(context),
                  _buildGoToRegisterButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForgotPassword(BuildContext context) {
    LoginViewModel viewModel =
        Provider.of<LoginViewModel>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
              onPressed: () {
                viewModel.goToForgotPasswordPage(context);
              },
              child: const Text("Şifremi Unuttum")),
        ],
      ),
    );
  }

  Widget _buildLogInButton(BuildContext context) {
    LoginViewModel viewModel =
        Provider.of<LoginViewModel>(context, listen: false);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF00B3C5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      child: const Text(
        "Giriş Yap",
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          viewModel.login(
            context,
            _emailController.text.trim(),
            _passwordController.text.trim(),
          );
        }
      },
    );
  }

  Widget _buildGoToRegisterButton(BuildContext context) {
    LoginViewModel viewModel =
        Provider.of<LoginViewModel>(context, listen: false);
    return TextButton(
        onPressed: () {
          viewModel.openRegisterPage(context);
        },
        child: const Text("Hesabınız Yok Mu? Hesap Oluştur"));
  }
}
