import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:musix/utils/constant.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:text_scroll/text_scroll.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;

showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}

String formatDuration(int totalSeconds) {
  final duration = Duration(seconds: totalSeconds);
  final minutes = duration.inMinutes;
  final seconds = totalSeconds % 60;

  final minutesString = '$minutes'.padLeft(2, '0');
  final secondsString = '$seconds'.padLeft(2, '0');
  return '$minutesString:$secondsString';
}

Future<String> getLyricFromLrcLink(String lrcLink) async {
  final response = await http.get(Uri.parse(lrcLink));
  String lyric = utf8.decode(response.bodyBytes);
  return lyric;
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

Widget defaultTextScrollWidget(String text) {
  return TextScroll(
    text,
    mode: TextScrollMode.bouncing,
    velocity: const Velocity(pixelsPerSecond: Offset(10, 0)),
    delayBefore: const Duration(seconds: 5),
    pauseBetween: const Duration(seconds: 3),
    style:
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
