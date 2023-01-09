import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class RotatedTextWidget extends StatelessWidget {
  final String text;
  const RotatedTextWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RotatedBox(
        quarterTurns: -1,
        child: Text(
          text,
          style: TextStyleTheme.ts22
              .copyWith(color: Colors.white, fontWeight: FontWeight.w300),
        ),
      ),
    );
  }
}
