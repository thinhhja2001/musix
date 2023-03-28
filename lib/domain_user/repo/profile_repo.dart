import 'dart:async';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:musix/global/repo/initial_repo.dart';

import '../models/models.dart';

class ProfileRepo extends InitialRepo {
  FutureOr<ProfileResponseModel> getProfile(String token, String id) async {
    const url = "profile/info";

    var response = await dio.get(
      url,
      options: Options(
        headers: headerApplicationJson(token: token),
      ),
      data: {"id": id},
    );
    if (response.statusCode == 200) {
      return ProfileResponseModel.fromJson(response.data['data']);
    } else {
      throw Exception("${response.statusCode}: ${response.data['msg']}");
    }
  }

  FutureOr<ProfileResponseModel> uploadProfile({
    required String token,
    required String id,
    String? birthday,
    String? phoneNumber,
    String? fullName,
  }) async {
    const url = "profile/info";
    Map<String, String> data = {"id": id};
    if (birthday != null) data["birthday"] = birthday;
    if (phoneNumber != null) data["phoneNumber"] = phoneNumber;
    if (fullName != null) data["fullName"] = fullName;

    var response = await dio.put(
      url,
      options: Options(
        headers: headerApplicationJson(token: token),
      ),
      data: data,
    );
    if (response.statusCode == 200) {
      return ProfileResponseModel.fromJson(response.data['data']);
    } else {
      throw Exception("${response.statusCode}: ${response.data['msg']}");
    }
  }

  FutureOr<ProfileResponseModel> uploadAvatar({
    required String token,
    required String id,
    required List<int> avatar,
  }) async {
    const url = "profile/avatar";

    var data = FormData.fromMap({
      'avatar': MultipartFile.fromBytes(
        avatar,
        filename: "image.png",
        contentType: MediaType.parse('image/jpeg'),
      ),
      'id': id,
    });

    var response = await dio.put(
      url,
      options: Options(
        headers: headerMultiFormData(token: token),
      ),
      data: data,
    );
    if (response.statusCode == 200) {
      return ProfileResponseModel.fromJson(response.data['data']);
    } else {
      throw Exception("${response.statusCode}: ${response.data['msg']}");
    }
  }

  FutureOr<ProfileResponseModel> changePassword({
    required String token,
    required String id,
    required String password,
    required String newPassword,
  }) async {
    const url = "profile/changePassword";

    var data = {
      'id': id,
      'password': password,
      'newPassword': newPassword,
    };

    var response = await dio.put(
      url,
      options: Options(
        headers: headerApplicationJson(token: token),
      ),
      data: data,
    );
    if (response.statusCode == 200) {
      return ProfileResponseModel.fromJson(response.data['data']);
    } else {
      throw Exception("${response.statusCode}: ${response.data['msg']}");
    }
  }

  FutureOr<ProfileResponseModel> followUser({
    required String token,
    required String id,
    required String followId,
  }) async {
    const url = "profile/follow";

    var data = {
      'id': id,
      'followId': followId,
    };

    var response = await dio.put(
      url,
      options: Options(
        headers: headerApplicationJson(token: token),
      ),
      data: data,
    );
    if (response.statusCode == 200) {
      return ProfileResponseModel.fromJson(response.data['data']);
    } else {
      throw Exception("${response.statusCode}: ${response.data['msg']}");
    }
  }
}
