// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:musix/domain_song/repository/recommendations/song_recommendation_repo.dart';
import 'package:musix/domain_song/services/recommendations/recommendation_service.dart';
import 'package:zing_mp3_api/zing_mp3_api.dart';

void main() async {
  GetIt.I.registerFactoryAsync<ZingMP3APIV2>(() => ZingMP3APIV2.createAsync());

  final recommendationRepo = SongRecommendationRepo();
  print('getting information');
  print(await recommendationRepo.generateRecommendPlaylist(["Z6UBADAF"]));
  // final recommendationService = RecommendationService();
  // printJson(await recommendationService.recommendNextSong("ZW6WUAEC", 5));
}

void printJson(Map<String, dynamic>? json) {
  JsonEncoder encoder = JsonEncoder.withIndent('  ');
  String prettyprint = encoder.convert(json);
  print(prettyprint);
}
