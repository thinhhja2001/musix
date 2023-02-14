import 'package:flutter/material.dart';
import 'package:musix/domain_music/models/models.dart';
import 'package:musix/domain_music/views/widgets.dart';

import '../../theme/theme.dart';

class CustomBottomBarWidget extends StatelessWidget {
  /// A bottom bar that faithfully follows the design by Aurélien Salomon
  ///
  /// https://dribbble.com/shots/5925052-Google-Bottom-Bar-Navigation-Pattern/
  const CustomBottomBarWidget({
    Key? key,
    required this.items,
    this.onTap,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.selectedColorOpacity,
    this.index,
    this.margin = const EdgeInsets.all(8),
    this.itemPadding = const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.easeOutQuint,
  }) : super(key: key);

  /// A list of tabs to display, ie `Home`, `Likes`, etc
  final List<CustomBottomBarItem> items;

  /// Returns the index of the tab that was tapped.
  final Function(int)? onTap;
  final int? index;

  /// The color of the icon and text when the item is selected.
  final Color? selectedItemColor;

  /// The color of the icon and text when the item is not selected.
  final Color? unselectedItemColor;

  /// The opacity of color of the touchable background when the item is selected.
  final double? selectedColorOpacity;

  /// A convenience field for the margin surrounding the entire widget.
  final EdgeInsets margin;

  /// The padding of each item.
  final EdgeInsets itemPadding;

  /// The transition duration
  final Duration duration;

  /// The transition curve
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: margin,
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: ColorTheme.backgroundDarker,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const CurrentSongPlayerWidget(),
            Container(
              height: 72,
              decoration: BoxDecoration(
                  color: ColorTheme.bottomNavigationBar,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                /// Using a different alignment when there are 2 items or less
                /// so it behaves the same as BottomNavigationBar.
                mainAxisAlignment: items.length <= 2
                    ? MainAxisAlignment.spaceEvenly
                    : MainAxisAlignment.spaceBetween,
                children: [
                  for (final item in items)
                    TweenAnimationBuilder<double>(
                      tween: Tween(
                        end: items.indexOf(item) == index ? 1.0 : 0.0,
                      ),
                      curve: curve,
                      duration: duration,
                      builder: (context, t, _) {
                        final selectedColor = item.selectedColor ??
                            selectedItemColor ??
                            ColorTheme.primary;

                        final unselectedColor = item.unselectedColor ??
                            unselectedItemColor ??
                            Colors.black;

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Material(
                            color: Color.lerp(selectedColor.withOpacity(0.0),
                                ColorTheme.primaryLighten, t),
                            borderRadius: BorderRadius.circular(12),
                            child: InkWell(
                              onTap: () => onTap?.call(items.indexOf(item)),
                              focusColor: ColorTheme.primaryLighten,
                              highlightColor: ColorTheme.primaryLighten,
                              splashColor: ColorTheme.primaryLighten,
                              hoverColor: ColorTheme.primaryLighten,
                              borderRadius: BorderRadius.circular(12),
                              child: Padding(
                                padding: itemPadding -
                                    (Directionality.of(context) ==
                                            TextDirection.ltr
                                        ? EdgeInsets.only(
                                            right: itemPadding.right * t)
                                        : EdgeInsets.only(
                                            left: itemPadding.left * t)),
                                child: Row(
                                  children: [
                                    IconTheme(
                                      data: IconThemeData(
                                        color: Color.lerp(
                                            unselectedColor, selectedColor, t),
                                        size: 24,
                                      ),
                                      child: items.indexOf(item) == index
                                          ? item.activeIcon ?? item.icon
                                          : item.icon,
                                    ),
                                    SizedBox(
                                      /// The Align property appears to make these full height, would be
                                      /// best to find a way to make it respond only to padding.
                                      height: 36,
                                      child: Align(
                                        alignment: const Alignment(-0.2, 0.0),
                                        widthFactor: t,
                                        child: Padding(
                                          padding: Directionality.of(context) ==
                                                  TextDirection.ltr
                                              ? EdgeInsets.only(
                                                  left: itemPadding.left / 2,
                                                  right: itemPadding.right)
                                              : EdgeInsets.only(
                                                  left: itemPadding.left,
                                                  right: itemPadding.right / 2),
                                          child: DefaultTextStyle(
                                            style: TextStyle(
                                              color: Color.lerp(
                                                  selectedColor
                                                      .withOpacity(0.0),
                                                  selectedColor,
                                                  t),
                                              fontWeight: FontWeight.w400,
                                            ),
                                            child: item.title,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A tab to display in a [CustomBottomBarWidget]
class CustomBottomBarItem {
  /// An icon to display.
  final Widget icon;

  /// An icon to display when this tab bar is active.
  final Widget? activeIcon;

  /// Text to display, ie `Home`
  final Widget title;

  /// A primary color to use for this tab.
  final Color? selectedColor;

  /// The color to display when this tab is not selected.
  final Color? unselectedColor;

  CustomBottomBarItem({
    required this.icon,
    required this.title,
    this.selectedColor,
    this.unselectedColor,
    this.activeIcon,
  });
}
