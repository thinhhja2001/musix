import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:musix/models/album.dart';
import 'package:musix/resources/playlist_methods.dart';
import 'package:musix/utils/colors.dart';
import 'package:musix/utils/constant.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:text_scroll/text_scroll.dart';

showSnackBar(String content, BuildContext context, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(content),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    ),
    backgroundColor: color,
    behavior: SnackBarBehavior.floating,
  ));
}

Widget goBackButton() {
  return GestureDetector(
      onTap: () => Get.back(),
      child: const Icon(MdiIcons.arrowLeft, color: Colors.white));
}

String formatDuration(int totalSeconds) {
  final duration = Duration(seconds: totalSeconds);
  final minutes = duration.inMinutes;
  final seconds = totalSeconds % 60;

  final minutesString = '$minutes'.padLeft(2, '0');
  final secondsString = '$seconds'.padLeft(2, '0');
  return '$minutesString:$secondsString';
}

Widget buildBlurredImage() => ClipRRect(
      // borderRadius: BorderRadius.circular(24),
      child: Stack(
        children: [
          Image.asset(
            'assets/images/Group 5.png',
            fit: BoxFit.cover,
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10.0,
                sigmaY: 10.0,
              ),
              child: Container(color: Colors.transparent),
            ),
          ),
        ],
      ),
    );
Future<PaletteGenerator> updatePaletteGenerator(String imageUrl) async {
  final paletteGenerator = await PaletteGenerator.fromImageProvider(
    Image.network(imageUrl).image,
  );
  return paletteGenerator;
}

Widget defaultTextScrollWidget({required String text, TextStyle? textStyle}) {
  return TextScroll(
    text,
    mode: TextScrollMode.bouncing,
    velocity: const Velocity(pixelsPerSecond: Offset(10, 0)),
    delayBefore: const Duration(seconds: 5),
    pauseBetween: const Duration(seconds: 3),
    style: textStyle ??
        kDefaultTextStyle.copyWith(fontSize: 15, fontWeight: FontWeight.w400),
    textAlign: TextAlign.right,
  );
}

Widget noAlbumData(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(left: 10.0),
    child: Container(
        width: MediaQuery.of(context).size.width / 2,
        height: MediaQuery.of(context).size.width / 2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: const DecorationImage(
                fit: BoxFit.fill, image: NetworkImage(noImageUrl)))),
  );
}

bool isOfficialAlbum(String albumKey) {
  if (albumKey.length <= 8) {
    return true;
  }

  return false;
}

showCompleteNotification(
    {required String title,
    required String message,
    required IconData icon,
    Color? color}) {
  Get.snackbar(title, message,
      backgroundColor: kBackgroundColor,
      colorText: Colors.white,
      titleText: Text(
        title,
        style: kDefaultTitleStyle,
      ),
      messageText: Text(
        message,
        style: kDefaultHintStyle.copyWith(color: kPrimaryColor),
      ),
      shouldIconPulse: false,
      icon: Icon(
        icon,
        color: color ?? Colors.white,
      ));
}
