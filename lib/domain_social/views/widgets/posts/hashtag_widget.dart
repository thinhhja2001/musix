import 'package:flutter/material.dart';

import '../../../../theme/theme.dart';

class HashtagWidget extends StatelessWidget {
  const HashtagWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "#huge",
          style: TextStyleTheme.ts14.copyWith(color: ColorTheme.white),
        ),
        Text(
          "#huge",
          style: TextStyleTheme.ts14.copyWith(color: ColorTheme.white),
        ),
        Text(
          "#huge",
          style: TextStyleTheme.ts14.copyWith(color: ColorTheme.white),
        ),
      ],
    );
  }
}
