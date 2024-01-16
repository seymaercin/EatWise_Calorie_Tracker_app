import 'package:eatwise_calorie_tracker/view_model/main_layout_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainLayoutPage extends StatelessWidget {
  const MainLayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    MainLayoutViewModel mainLayoutViewModel =
        Provider.of<MainLayoutViewModel>(context, listen: false);

    return Consumer<MainLayoutViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(50),
              ),
            ),
            backgroundColor: const Color(
              0xFF007B9B,
            ),
            title: Image.asset(
              "assets/eatwiselogo.png",
              width: 180,
              fit: BoxFit.cover,
            ),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    mainLayoutViewModel.signOut(context);
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  )),
            ],
          ),
          body: Center(child: viewModel.pages[viewModel.selectedIndex]),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: viewModel.selectedIndex,
            onTap: viewModel.navBarOnTap,
            backgroundColor: const Color(0xFF007B9B),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Colors.white,
                  size: 40,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 40,
                ),
                label: '',
              ),
            ],
          ),
        );
      },
    );
  }
}
