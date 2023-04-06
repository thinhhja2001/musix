import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:palette_generator/palette_generator.dart';

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
  var format = DateFormat('HH:mm a');
  var date = DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
  var diff = date.difference(now);
  var time = '';

  if (diff.inSeconds <= 0 ||
      diff.inSeconds > 0 && diff.inMinutes == 0 ||
      diff.inMinutes > 0 && diff.inHours == 0 ||
      diff.inHours > 0 && diff.inDays == 0) {
    time = "Today at ${format.format(date)}";
  } else {
    if (diff.inDays == 1) {
      time = '${diff.inDays}DAY AGO';
    } else {
      time = '${diff.inDays}DAYS AGO';
    }
  }

  return time;
}
