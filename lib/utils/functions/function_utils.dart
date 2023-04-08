import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:shimmer/shimmer.dart';

import '../../theme/color.dart';

Future<PaletteGenerator> updatePaletteGenerator(String imageUrl) async {
  final paletteGenerator = await PaletteGenerator.fromImageProvider(
    Image.network(imageUrl).image,
  );
  return paletteGenerator;
}

String printDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  if (duration.inHours > 0) {
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  } else {
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}

Future<String> getLyric(String lyricUrl) async {
  String lyric = "";
  try {
    final response = await http.get(
      Uri.parse(lyricUrl),
    );
    lyric = utf8.decode(response.bodyBytes);
  } catch (e) {
    lyric = "";
  }
  return lyric;
}

formatTime({required int timeInSecond}) {
  int sec = timeInSecond % 60;
  int min = (timeInSecond / 60).floor();
  String minute = min.toString().length <= 1 ? "0$min" : "$min";
  String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
  return "$minute : $second";
}

void printJson(Map<String, dynamic>? json) {
  JsonEncoder encoder = const JsonEncoder.withIndent('  ');
  String prettyprint = encoder.convert(json);
  debugPrint(prettyprint);
}

String readTimestamp(int timestamp) {
  var now = DateTime.now();
  var hourFormat = DateFormat('HH:mm a');
  var dateCreated = DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
  var diff = dateCreated.difference(now);
  var time = '';
  var diffInDate = now.day - dateCreated.day;
  if (diffInDate == 0) {
    return "Today at ${hourFormat.format(dateCreated)}";
  } else if (diffInDate == 1) {
    return "Yesterday at ${hourFormat.format(dateCreated)}";
  } else if (diffInDate < 7) {
    return "$diffInDate days ago";
  }
  var dateFormat = DateFormat.yMMMd();
  return dateFormat.format(dateCreated);
}

Widget shimmerLoadingEffect({required double width, double? height}) =>
    Shimmer.fromColors(
      baseColor: ColorTheme.background,
      highlightColor: ColorTheme.backgroundDarker,
      child: Material(
        color: Colors.white,
        child: SizedBox(
          width: width,
          height: height ?? 240,
        ),
      ),
    );
