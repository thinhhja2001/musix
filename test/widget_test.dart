// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:musix/domain_music/repository/song_repository.dart';

import 'package:musix/main.dart';

void main() async {
  SongRepositoryImpl songRepositoryImpl = SongRepositoryImpl();
  final song = await songRepositoryImpl.getInfo('ZW6I7899');
  printJson(song.toJson());
}

void printJson(Map<String, dynamic>? json) {
  JsonEncoder encoder = JsonEncoder.withIndent('  ');
  String prettyprint = encoder.convert(json);
  print(prettyprint);
}
