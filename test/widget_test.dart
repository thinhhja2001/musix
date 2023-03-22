// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';

import 'package:musix/domain_artist/models/get_artist_model/artist_model.dart';
import 'package:musix/domain_auth/payload/request/login_request.dart';
import 'package:musix/domain_song/repository/repository.dart';
import 'package:musix/domain_auth/payload/request/register_request.dart';
import 'package:musix/domain_auth/repo/auth_repo.dart';
import 'package:musix/domain_auth/services/auth_service.dart';

void main() async {
  AuthRepo authRepo = AuthRepo();

  // var response = await authRepo.register(RegisterRequest(
  //     username: "thinhhja2001",
  //     fullName: "Nguyen Doan Thinh",
  //     email: "thinhnguyendoan5122001@gmail.com",
  //     password: "talavua5122001",
  //     birthday: "05/12/2001",
  //     phoneNumber: "032838445"));
  var response = await authRepo
      .login(LoginRequest(username: 'thinhhh', password: 'alksnlkfasn'));
}

void printJson(Map<String, dynamic>? json) {
  JsonEncoder encoder = JsonEncoder.withIndent('  ');
  String prettyprint = encoder.convert(json);
  print(prettyprint);
}
