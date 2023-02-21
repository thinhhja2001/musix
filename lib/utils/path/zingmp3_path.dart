import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:zing_mp3_api/zing_mp3_api.dart';

import '../../config/register_dependency.dart';

class ZingMp3Repo {
  void getAlbum() async {
    ZingMP3APIV2 api = await getIt.getAsync<ZingMP3APIV2>();
    printJson(await api.getGenreById('IWZ9Z08I'));
  }

  void printJson(Map<String, dynamic>? json) {
    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
    String prettyprint = encoder.convert(json);
    debugPrint(prettyprint);
  }
}
