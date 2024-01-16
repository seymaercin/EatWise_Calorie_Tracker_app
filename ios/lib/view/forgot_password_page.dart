import 'package:eatwise_calorie_tracker/view/common/common_text_field.dart';
import 'package:eatwise_calorie_tracker/view_model/forgot_password_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _buildIconButton(context),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(50),
          ),
        ),
        backgroundColor: const Color(
          0xFF007B9B,
        ),
        title: const Text(
          "Şifre Sıfırlama",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildText(),
              const SizedBox(
                height: 20,
              ),
              CommonTextFiled(
                controller: _emailController,
                obscureText: false,
                label: "Email",
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 20,
              ),
              _buildButton(context, _emailController.text.trim()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton(BuildContext context) {
    ForgotPasswordViewModel viewModel =
        Provider.of<ForgotPasswordViewModel>(context, listen: false);
    return IconButton(
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.white,
      ),
      onPressed: () {
        viewModel.goBackLoginPage(context);
      },
    );
  }

  Widget _buildText() {
    return const Text(
      "Şifrenizi sıfırlamak için email adresinizi girin.",
      style: TextStyle(fontSize: 18),
    );
  }

  Widget _buildButton(BuildContext context, String email) {
    ForgotPasswordViewModel viewModel =
        Provider.of<ForgotPasswordViewModel>(context, listen: false);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF00B3C5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      child: const Text(
        "Şifremi Sıfırla",
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        viewModel.resetPassword(context, email);
      },
    );
  }
}
