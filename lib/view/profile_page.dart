import 'package:eatwise_calorie_tracker/view_model/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _bmiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (context, viewModel, child) {
        double bmi = viewModel.calculateBMI(viewModel.kilo, viewModel.boy);
        _nameController.text = viewModel.userName;
        _ageController.text = viewModel.yas;
        _heightController.text = viewModel.boy;
        _weightController.text = viewModel.kilo;
        _emailController.text = viewModel.email;
        _bmiController.text = bmi.toStringAsFixed(2);
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildTextField("Ad:", _nameController, true),
                buildTextField("Yaş:", _ageController, true),
                buildTextField("Boy:", _heightController, true),
                buildTextField("Kilo", _weightController, true),
                buildTextField("Email:", _emailController, false),
                buildTextField("Vücut Kütle İndeksi", _bmiController, false),
                ElevatedButton(
                  onPressed: () {
                    viewModel.updateUserData(
                        _nameController.text,
                        _ageController.text,
                        _heightController.text,
                        _weightController.text,
                        _emailController.text,
                        context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00B3C5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    'Güncelle',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildTextField(
      String label, TextEditingController controller, bool enabled) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        controller: controller,
        enabled: enabled,
        decoration: InputDecoration(
          label: Text(label),
          hintText: 'Değer girin',
        ),
      ),
    );
  }
}
