import 'package:eatwise_calorie_tracker/view_model/basket_view_model.dart';
import 'package:eatwise_calorie_tracker/view_model/total_calorie_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BasketPage extends StatelessWidget {
  final int _category;

  const BasketPage(this._category, {super.key});

  @override
  Widget build(BuildContext context) {
    BasketViewModel viewModel =
        Provider.of<BasketViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF007B9B),
        title: const Text("Besin Kalori Hesabı",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(50),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/bucketlist.png"),
                SizedBox(
                  height: 150,
                  width: 150,
                  child: Container(
                    alignment: Alignment.center,
                    child: Consumer<TotalCalorieProvider>(
                      builder: (context, viewModel, child) => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "TOPLAM",
                            style: TextStyle(
                                color: Color(0xff00B3C5),
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${viewModel.calories[_category]}",
                            style: const TextStyle(
                                fontSize: 28,
                                color: Color(0xff00B3C5),
                                fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            "KALORİ",
                            style: TextStyle(
                                color: Color(0xff00B3C5),
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Consumer<TotalCalorieProvider>(
                  builder: (context, viewModel, child) {
                return ListView.separated(
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: viewModel.cartItems[_category].length,
                  itemBuilder: (context, index) {
                    final item = viewModel.cartItems[_category][index];

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(item.image),
                      ),
                      title: Text(item.name),
                      subtitle:
                          Text("${item.calorie} kalori / ${item.gram} gram"),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          viewModel.deleteItem(context, item, _category);
                        },
                      ),
                    );
                  },
                );
              }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00B3C5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: () {
                    viewModel.goToListofItemPage(context);
                  },
                  child: const Text(
                    "Besin Ekle",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00B3C5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: () {
                    viewModel.goMainPage(context);
                  },
                  child: const Text(
                    "Ana Sayfa",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
