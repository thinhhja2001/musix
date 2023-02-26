// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';

import 'package:musix/domain_song/repository/repository.dart';

void main() async {
  VideoRepositoryImpl videoRepositoryImpl = VideoRepositoryImpl();
  SongInfoRepositoryImpl songInfoRepositoryImpl = SongInfoRepositoryImpl();
  final songs = await songInfoRepositoryImpl.getByQuery("anh");
  for (var song in songs) {
    printJson(song.toJson());
  }
  // final videos = await videoRepositoryImpl.getByQuery("Anh");
  // for (var video in videos) {
  //   printJson(video.toJson());
  // }
}

void printJson(Map<String, dynamic>? json) {
  JsonEncoder encoder = JsonEncoder.withIndent('  ');
  String prettyprint = encoder.convert(json);
  print(prettyprint);
}
