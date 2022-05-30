import 'package:flutter/material.dart';
import 'package:musix/models/users.dart';
import 'package:musix/resources/auth_methods.dart';
import 'package:musix/utils/constant.dart';
import 'package:musix/widgets/customs/custom_bottom_navigation_bar.dart';
import 'package:musix/widgets/home/billboad_widget.dart';
import 'package:musix/widgets/home/explore_widget.dart';

import '../screens/search_screen.dart';

class CustomBottomBarProvider extends ChangeNotifier {
  bool userLoaded = false;
  int currentIndex = 0;
  late CustomBottomBar customBottomBar;
  Users? users;

  CustomBottomBarProvider() {
    getCurrentUser().then((value) => updateUserLoaded());
    customBottomBar = CustomBottomBar(
      items: bottomBarItems,
      onTap: updateCurrentIndex,
    );
  }
  Future<void> getCurrentUser() async {
    users = await AuthMethods().getCurrentUser();
    notifyListeners();
  }

  void updateUserLoaded() {
    userLoaded = true;
  }

  void updateCurrentIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  Widget buildBody() {
    List<Widget> bottomBarWidget = [
      userLoaded
          ? BillboardWidget(user: users!)
          : const Center(
              child: CircularProgressIndicator(),
            ),
      userLoaded
          ? ExploreWidget(user: users!)
          : const Center(
              child: CircularProgressIndicator(),
            ),
      const SearchScreen(),
    ];
    return IndexedStack(index: currentIndex, children: bottomBarWidget);
  }
}
