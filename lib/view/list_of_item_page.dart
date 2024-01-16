import 'package:eatwise_calorie_tracker/view_model/list_of_item_view_model.dart';
import 'package:eatwise_calorie_tracker/view_model/total_calorie_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListOfItemPage extends StatelessWidget {
  final int _category;

  const ListOfItemPage(this._category, {super.key});

  @override
  Widget build(BuildContext context) {
    TotalCalorieProvider totalViewModel =
        Provider.of<TotalCalorieProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF007B9B),
        title: const Text("Besin Listesi",
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
            Expanded(child: Consumer<ListOfItemViewModel>(
                builder: (context, viewModel, child) {
              return ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                itemCount: viewModel.besinList.length,
                itemBuilder: (context, index) {
                  final item = viewModel.besinList[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(item.image),
                    ),
                    title: Text(item.name),
                    subtitle:
                        Text("${item.calorie} kalori / ${item.gram} gram"),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.add,
                        color: Color(0xFF005174),
                      ),
                      onPressed: () {
                        totalViewModel.addItem(item, _category, context);
                      },
                    ),
                  );
                },
              );
            })),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00B3C5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              onPressed: () {
                ListOfItemViewModel viewModel =
                    Provider.of<ListOfItemViewModel>(context, listen: false);

                viewModel.openBasketPage(context, _category);
              },
              child: const Text(
                "Kalori Hesapla",
                style: TextStyle(color: Colors.white),
              ),
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
