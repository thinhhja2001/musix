import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class CustomErrorBox extends StatelessWidget {
  const CustomErrorBox({
    super.key,
    required this.message,
  });
  final String message;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: ColorTheme.error, borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: TextStyleTheme.ts14
              .copyWith(color: ColorTheme.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
