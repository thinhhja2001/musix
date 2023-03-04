import 'package:flutter/material.dart';

import '../../../../theme/theme.dart';

class SearchBarNavigationWidget extends StatelessWidget {
  final String hintText;
  final VoidCallback? onTap;

  const SearchBarNavigationWidget({
    super.key,
    required this.hintText,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // height: 100,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: ColorTheme.bottomNavigationBar,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorTheme.background,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          hintText,
                          style: TextStyleTheme.ts15.copyWith(
                            color: ColorTheme.grey100,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: ColorTheme.primaryLighten,
                        ),
                        child: const Center(
                          child: IconButton(
                            onPressed: null,
                            icon: Icon(Icons.search),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
