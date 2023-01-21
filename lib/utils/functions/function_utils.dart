import 'package:flutter/widgets.dart';
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
