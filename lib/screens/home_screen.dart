import 'package:flutter/material.dart';
import 'package:musix/providers/custom_bottom_bar_provider.dart';
import 'package:musix/utils/colors.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomBottomBarProvider customBottomBarProvider =
        Provider.of<CustomBottomBarProvider>(context);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      bottomNavigationBar: customBottomBarProvider.customBottomBar,
      body: customBottomBarProvider.buildBody(),
    );
  }
}
