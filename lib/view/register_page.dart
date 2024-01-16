import 'package:eatwise_calorie_tracker/view/common/common_text_field.dart';
import 'package:eatwise_calorie_tracker/view_model/register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _kiloController = TextEditingController();
  final TextEditingController _boyController = TextEditingController();
  final TextEditingController _yasController = TextEditingController();

  RegisterPage({super.key});

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
                    controller: _userNameController,
                    obscureText: false,
                    label: "İsim",
                    keyboardType: TextInputType.name,
                  ),
                  CommonTextFiled(
                    controller: _boyController,
                    obscureText: false,
                    label: "Boy",
                    keyboardType: TextInputType.number,
                  ),
                  CommonTextFiled(
                    controller: _kiloController,
                    obscureText: false,
                    label: "Kilo",
                    keyboardType: TextInputType.number,
                  ),
                  CommonTextFiled(
                    controller: _yasController,
                    obscureText: false,
                    label: "Yaş",
                    keyboardType: TextInputType.number,
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
                  CommonTextFiled(
                    controller: _passwordConfirmController,
                    obscureText: true,
                    label: "Şifre Tekrar",
                    keyboardType: TextInputType.multiline,
                  ),
                  _buildLoginButton(context),
                  _buildOpenRegisterButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    RegisterViewModel viewModel = Provider.of<RegisterViewModel>(
      context,
      listen: false,
    );
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF00B3C5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      child: const Text("Kayıt Ol", style: TextStyle(color: Colors.white)),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          viewModel.register(
            context,
            _emailController.text.trim(),
            _passwordController.text.trim(),
            _userNameController.text.trim(),
            _kiloController.text.trim(),
            _boyController.text.trim(),
            _yasController.text.trim(),
          );
        }
      },
    );
  }

  Widget _buildOpenRegisterButton(BuildContext context) {
    RegisterViewModel viewModel = Provider.of<RegisterViewModel>(
      context,
      listen: false,
    );
    return TextButton(
      child: const Text("Hesabınız var mı? Giriş yapın"),
      onPressed: () {
        viewModel.openLoginPage(context);
      },
    );
  }
}
