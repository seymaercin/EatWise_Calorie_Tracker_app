import 'package:flutter/material.dart';

class BasketViewModel with ChangeNotifier {
  void goToListofItemPage(BuildContext context) {
    Navigator.pop(context);
  }

  void goMainPage(BuildContext context) {
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
