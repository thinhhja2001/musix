// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:musix/domain_social/models/post/request/post_registry_model.dart';
import 'package:musix/domain_social/repository/post/post_repo.dart';
import 'package:zing_mp3_api/zing_mp3_api.dart';

void main() async {
  GetIt.I.registerFactoryAsync<ZingMP3APIV2>(() => ZingMP3APIV2.createAsync());

  PostRepo repo = PostRepo();
  var response = await repo.modifyPost(
      postId: "642c487cca1b275728d79a3c",
      postRegistryModel: PostRegistryModel(content: "modify from flutter"),
      token:
          "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1c2VydGVzdDIiLCJpYXQiOjE2Nzk3MzQ4NzQsImV4cCI6MTY4MjMyNjg3NH0.wlz5GF1g4NhUYiWcvDhv5BDovsJgpNCpozu6jNRA2LA");
  printJson(response.toJson());
}

void printJson(Map<String, dynamic>? json) {
  JsonEncoder encoder = JsonEncoder.withIndent('  ');
  String prettyprint = encoder.convert(json);
  print(prettyprint);
}
