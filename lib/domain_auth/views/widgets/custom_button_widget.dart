import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget({
    Key? key,
    required this.onPress,
    required this.content,
    this.isLoading,
    this.backgroundColor,
    this.width,
    this.height,
  }) : super(key: key);
  final VoidCallback onPress;
  final String content;
  final bool? isLoading;
  final Color? backgroundColor;
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? ColorTheme.primary),
        onPressed: onPress,
        child: (isLoading != null && isLoading == true)
            ? const CircularProgressIndicator(
                color: ColorTheme.white,
              )
            : Text(
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
