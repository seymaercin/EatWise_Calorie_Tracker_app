import 'package:eatwise_calorie_tracker/view_model/total_calorie_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 5,),
          _buildContainer(),
          const SizedBox(
            height: 30,
          ),
          _buildKahvaltiButton(context),
          const SizedBox(
            height: 30,
          ),
          _buildOgleButton(context),
          const SizedBox(
            height: 30,
          ),
          _buildAksamButton(context),
        ],
      ),
    );
  }

  Widget _buildContainer() {
    return SizedBox(
      width: 170,
      height: 170,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: const Color(0xFF007B9B),
        ),
        child: Consumer<TotalCalorieProvider>(
          builder: (context, viewModel, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Toplam Kalori",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Text(
                  viewModel.totalCalorie.toStringAsFixed(0),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildKahvaltiButton(BuildContext context) {
    TotalCalorieProvider viewModel =
        Provider.of<TotalCalorieProvider>(context, listen: false);
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            viewModel.goToListOfItemPage(context, 0);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00B3C5),
            minimumSize: const Size(300, 70),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(40))),
          ),
          child: const Text(
            "Kahvaltı",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Consumer<TotalCalorieProvider>(builder: (context, viewModel, child) {
          return Text(
            "Kahvaltı Toplam Kalori : ${viewModel.calories[0]}",
          );
        }),
      ],
    );
  }

  Widget _buildOgleButton(BuildContext context) {
    TotalCalorieProvider viewModel =
        Provider.of<TotalCalorieProvider>(context, listen: false);
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            viewModel.goToListOfItemPage(context, 1);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF007B9B),
            minimumSize: const Size(300, 70),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(40))),
          ),
          child: const Text(
            "Öğle",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Consumer<TotalCalorieProvider>(builder: (context, viewModel, child) {
          return Text(
            "Öğle Toplam Kalori : ${viewModel.calories[1]}",
          );
        }),
      ],
    );
  }

  Widget _buildAksamButton(BuildContext context) {
    TotalCalorieProvider viewModel =
        Provider.of<TotalCalorieProvider>(context, listen: false);
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            viewModel.goToListOfItemPage(context, 2);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF005174),
            minimumSize: const Size(300, 70),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(40))),
          ),
          child: const Text(
            "Akşam",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Consumer<TotalCalorieProvider>(builder: (context, viewModel, child) {
          return Text(
            "Akşam Toplam Kalori : ${viewModel.calories[2]}",
          );
        }),
      ],
    );
  }
}
