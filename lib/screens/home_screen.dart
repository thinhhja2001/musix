import 'package:flutter/material.dart';
import 'package:musix/resources/auth_methods.dart';
import 'package:musix/utils/colors.dart';

import '../models/users.dart';
import '../utils/constant.dart';
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
    List<Widget> bottomBarWidget = [
      userLoaded
          ? BillboardWidget(user: users!)
          : const Center(
              child: CircularProgressIndicator(),
            ),
      const Center(
          child: Text(
        "Explore screen",
        style: TextStyle(color: Colors.white),
      ))
    ];
    return IndexedStack(index: currentIndex, children: bottomBarWidget);
  }
}
