import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatwise_calorie_tracker/model/besin_model.dart';
import 'package:eatwise_calorie_tracker/view/basket_page.dart';
import 'package:eatwise_calorie_tracker/view_model/basket_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListOfItemViewModel with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final List<BesinModel> _besinList = [];

  List<BesinModel> get besinList => _besinList;

  ListOfItemViewModel() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getBesinList();
    });
  }

  void _getBesinList() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection("besin").orderBy("name").get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
        in snapshot.docs) {
      BesinModel besinModel = BesinModel.fromMap(
        documentSnapshot.id,
        documentSnapshot.data(),
      );
      _besinList.add(besinModel);
    }
    notifyListeners();
  }

  void openBasketPage(BuildContext context, int category) {
    MaterialPageRoute pageRoute = MaterialPageRoute(
      builder: (context) => ChangeNotifierProvider(
        create: (context) => BasketViewModel(),
        child: BasketPage(category),
      ),
    );
    Navigator.push(context, pageRoute);
  }
}
