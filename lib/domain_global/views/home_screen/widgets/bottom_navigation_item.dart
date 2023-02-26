import 'package:flutter/material.dart';

import '../../../../global/widgets/custom_bottom_navigation_widget.dart';
import '../../../../theme/theme.dart';
import '../utils/text_path.dart';

List<CustomBottomBarItem> bottomNavigationItems(BuildContext context) {
  final homeTextPath = HomeTextPath();
  return [
    CustomBottomBarItem(
        icon: const Icon(Icons.star_outline),
        title: Text(
          homeTextPath.billboard,
          style: TextStyleTheme.ts15.copyWith(
            fontWeight: FontWeight.w400,
          ),
        ),
        unselectedColor: Colors.white,
        selectedColor: Colors.black),
    CustomBottomBarItem(
        icon: const Icon(Icons.explore_outlined),
        title: Text(homeTextPath.explore,
            style: TextStyleTheme.ts15.copyWith(
              fontWeight: FontWeight.w400,
            )),
        unselectedColor: Colors.white,
        selectedColor: Colors.black),
    CustomBottomBarItem(
        icon: const Icon(Icons.search_outlined),
        title: Text(homeTextPath.search,
            style: TextStyleTheme.ts15.copyWith(
              fontWeight: FontWeight.w400,
            )),
        unselectedColor: Colors.white,
        selectedColor: Colors.black),
    CustomBottomBarItem(
        icon: const Icon(Icons.smart_display_outlined),
        title: Text(homeTextPath.video,
            style: TextStyleTheme.ts15.copyWith(
              fontWeight: FontWeight.w400,
            )),
        unselectedColor: Colors.white,
        selectedColor: Colors.black),
  ];
}
