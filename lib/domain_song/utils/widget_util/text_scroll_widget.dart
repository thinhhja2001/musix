import 'package:flutter/material.dart';
import '../../../theme/text_style.dart';
import 'package:text_scroll/text_scroll.dart';

Widget defaultTextScrollWidget({required String text, TextStyle? textStyle}) {
  return TextScroll(
    text,
    mode: TextScrollMode.bouncing,
    velocity: const Velocity(pixelsPerSecond: Offset(10, 0)),
    delayBefore: const Duration(seconds: 5),
    pauseBetween: const Duration(seconds: 3),
    style: textStyle ??
        TextStyleTheme.ts15.copyWith(
          fontWeight: FontWeight.w400,
        )
    // TextStyleTheme.copyWith(fontSize: 15, fontWeight: FontWeight.w400),,
    ,
    textAlign: TextAlign.right,
  );
}
