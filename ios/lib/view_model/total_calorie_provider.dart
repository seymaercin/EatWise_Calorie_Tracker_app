import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatwise_calorie_tracker/model/besin_model.dart';
import 'package:eatwise_calorie_tracker/view/list_of_item_page.dart';
import 'package:eatwise_calorie_tracker/view_model/list_of_item_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TotalCalorieProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  int _totalCalorie = 0;
  int get totalCalorie => _totalCalorie;

  final List<List<BesinModel>> _cartItems = [];

  List<List<BesinModel>> get cartItems => _cartItems;

  List<int> calories = [0, 0, 0];

  TotalCalorieProvider() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getBasketList();
    });
  }

  Future<void> getBasketList() async {
    clear();
    String? uid = _auth.currentUser?.uid;
    if (uid != null) {
      try {
        DocumentSnapshot<Map<String, dynamic>> userDoc =
            await _firestore.collection("users").doc(uid).get();

        List<List<dynamic>> cartItemsRetrieved = [];

        for (int i = 0; i < 3; i++) {
          _cartItems.add([]);
          cartItemsRetrieved.add(userDoc.data()?["cart$i"] ?? []);
        }

        for (int i = 0; i < cartItemsRetrieved.length; i++) {
          List<dynamic> cartList = cartItemsRetrieved[i];
          for (Map<String, dynamic>? cartMap in cartList) {
            if (cartMap != null) {
              BesinModel besinModel = BesinModel.fromMap("", cartMap);

              _cartItems[i].add(besinModel);
            }
          }
        }

        calculateTotalCalorie();
      } catch (e) {
        print("Hata: $e");
      }
    }
  }

  void calculateTotalCalorie() {
    _totalCalorie = 0;
    for (var i = 0; i < _cartItems.length; i++) {
      _totalCalorie += totalCalorieForButton(_cartItems[i], i);
    }
    notifyListeners();
  }

  int totalCalorieForButton(List<BesinModel> itemList, int kategori) {
    int total = 0;
    for (var i = 0; i < itemList.length; i++) {
      total += int.parse(itemList[i].calorie);
    }
    calories[kategori] = total;
    return calories[kategori];
  }

  void addItem(
      BesinModel besinModel, int category, BuildContext context) async {
    String? uid = _auth.currentUser?.uid;
    if (uid != null) {
      await _firestore.collection("users").doc(uid).update({
        "cart$category": FieldValue.arrayUnion([
          besinModel.toMap(),
        ]),
      });
      getBasketList();
    }
    _showSnackbar(context, "Besin eklendi");
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    SnackBar snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(milliseconds: 200),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void deleteItem(
      BuildContext context, BesinModel besinModel, int category) async {
    String? uid = _auth.currentUser?.uid;
    if (uid != null) {
      await _firestore.collection("users").doc(uid).update({
        "cart$category": FieldValue.arrayRemove([
          besinModel.toMap(),
        ]),
      });
      getBasketList();
    }
  }

  void goToListOfItemPage(BuildContext context, int category) {
    MaterialPageRoute pageRoute = MaterialPageRoute(
      builder: (context) => ChangeNotifierProvider(
        create: (context) => ListOfItemViewModel(),
        child: ListOfItemPage(category),
      ),
    );
    Navigator.push(context, pageRoute);
  }

  void clear() {
    _cartItems.clear();
    _totalCalorie = 0;
  }
}
