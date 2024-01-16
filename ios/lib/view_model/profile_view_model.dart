import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatwise_calorie_tracker/view/common/common_show_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileViewModel with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String email = "";
  String userName = "";
  String boy = "";
  String kilo = "";
  String yas = "";

  ProfileViewModel() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      fetchUserData();
    });
  }

  void fetchUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> userData =
          await _firestore.collection('users').doc(user.uid).get();
      if (userData.exists) {
        email = userData['email'] ?? '';
        userName = userData['userName'] ?? '';
        kilo = userData['kilo'] ?? '';
        boy = userData['boy'] ?? '';
        yas = userData['yas'] ?? '';
        notifyListeners();
      }
    }
  }

  void updateUserData(
    String newUserName,
    String newAge,
    String newHeight,
    String newWeight,
    String newEmail,
    BuildContext context,
  ) async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        await _firestore.collection('users').doc(user.uid).update({
          'userName': newUserName,
          'kilo': newWeight,
          'boy': newHeight,
          'yas': newAge,
          'email': newEmail,
        });
        CommonShowDialog.myShowDialog(context,"Profil Güncellendi");
        fetchUserData();
      } on FirebaseAuthException catch (e) {
        print(e.message);
      }
    }
  }

 

  double calculateBMI(String weight, String height) {
    try {
      double kilo = double.parse(weight);
      double boy = double.parse(height) / 100;

      if (kilo > 0 && boy > 0) {
        double bmi = kilo / (boy * boy);
        return bmi;
      } else {
        return 0;
      }
    } catch (e) {
      print("Hata: $e");
      return 0;
    }
  }
}
