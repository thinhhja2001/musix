import 'package:flutter/material.dart';
import 'package:musix/resources/auth_methods.dart';
import 'package:musix/utils/colors.dart';

import '../models/users.dart';
import '../widgets/customs/custom_bottom_navigation_bar.dart';
import '../widgets/home/billboad_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool userLoaded = false;
  int _currentIndex = 0;

  Users? users;
  Future<void> getCurrentUser() async {
    users = await AuthMethods().getCurrentUser();
  }

  void userLoad() {
    setState(() {
      userLoaded = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getCurrentUser().then((value) => {userLoad()});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<CustomBottomBarItem> bottomBarItems = [
      CustomBottomBarItem(
          icon: const Icon(Icons.star_outline),
          title: const Text("Billboard"),
          unselectedColor: Colors.white,
          selectedColor: Colors.black),
      CustomBottomBarItem(
          icon: const Icon(Icons.favorite_outline),
          title: const Text("Explore"),
          unselectedColor: Colors.white,
          selectedColor: Colors.black),
      CustomBottomBarItem(
          icon: const Icon(Icons.search_outlined),
          title: const Text("Search"),
          unselectedColor: Colors.white,
          selectedColor: Colors.black),
    ];
    return Scaffold(
      backgroundColor: kBackgroundColor,
      bottomNavigationBar: CustomBottomBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          items: bottomBarItems),
      body: _buildBody(context, _currentIndex),
    );
  }

  Widget _buildBody(BuildContext context, int currentIndex) {
    return currentIndex == 0
        ? (userLoaded
            ? BillboardWidget(user: users!)
            : const Center(child: CircularProgressIndicator()))
        : Center(
            child: Container(
            child: const Text(
              "Explore screen",
              style: TextStyle(color: Colors.white),
            ),
          ));
  }
}
