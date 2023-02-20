import 'package:flutter/material.dart';

import '../../../../theme/theme.dart';

class PlayButtonWidget extends StatelessWidget {
  const PlayButtonWidget({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          color: ColorTheme.primary,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.pause,
          size: 50,
          color: Colors.white,
        ),
      ),
    );
  }
}
