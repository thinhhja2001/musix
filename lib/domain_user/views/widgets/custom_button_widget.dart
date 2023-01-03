import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget({
    Key? key,
    required this.onPress,
    required this.content,
  }) : super(key: key);
  final VoidCallback onPress;
  final String content;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: ColorTheme.primary),
        onPressed: onPress,
        child: Text(
          content,
          style: TextStyleTheme.ts15.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
