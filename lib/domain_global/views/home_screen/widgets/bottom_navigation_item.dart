import 'package:flutter/material.dart';

import '../../../../global/widgets/custom_bottom_navigation_widget.dart';
import '../../../../theme/theme.dart';

List<CustomBottomBarItem> bottomNavigationItems(BuildContext context) {
  return [
    CustomBottomBarItem(
        icon: const Icon(Icons.star_outline),
        title: Text(
          r'Music',
          style: TextStyleTheme.ts15.copyWith(
            fontWeight: FontWeight.w400,
          ),
        ),
        unselectedColor: Colors.white,
        selectedColor: Colors.black),
    CustomBottomBarItem(
        icon: const Icon(Icons.explore_outlined),
        title: Text(r'Social',
            style: TextStyleTheme.ts15.copyWith(
              fontWeight: FontWeight.w400,
            )),
        unselectedColor: Colors.white,
        selectedColor: Colors.black),
    CustomBottomBarItem(
        icon: const Icon(Icons.smart_display_outlined),
        title: Text(r'Video',
            style: TextStyleTheme.ts15.copyWith(
              fontWeight: FontWeight.w400,
            )),
        unselectedColor: Colors.white,
        selectedColor: Colors.black),
    CustomBottomBarItem(
        icon: const Icon(Icons.person_outline),
        title: Text(r'User',
            style: TextStyleTheme.ts15.copyWith(
              fontWeight: FontWeight.w400,
            )),
        unselectedColor: Colors.white,
        selectedColor: Colors.black),
  ];
}
