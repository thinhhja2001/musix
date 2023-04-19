import 'dart:async';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import '../../global/repo/initial_repo.dart';
import '../../utils/enum/error_data.dart';
import '../models/models.dart';

class ProfileRepo extends InitialRepo {
  FutureOr<ProfileResponseModel> getProfile(String token) async {
    const url = "/profile/info";
    try {
      var response = await dio.get(
        url,
        options: Options(
          headers: headerApplicationJson(token: token),
        ),
      );
      return ProfileResponseModel.fromJson(response.data['data']);
    } on DioError catch (e) {
      throw ResponseException(
          statusCode: e.response?.statusCode,
          message: e.response?.data?["msg"] ?? exception);
    }
  }

  FutureOr<ProfileResponseModel> getOtherProfile(
      String token, String id) async {
    final url = "/profile/$id";
    try {
      var response = await dio.get(
        url,
        options: Options(
          headers: headerApplicationJson(token: token),
        ),
      );
      return ProfileResponseModel.fromJson(response.data['data']);
    } on DioError catch (e) {
      throw ResponseException(
          statusCode: e.response?.statusCode,
          message: e.response?.data?["msg"] ?? exception);
    }
  }

  FutureOr<ProfileResponseModel> uploadProfile({
    required String token,
    String? birthday,
    String? phoneNumber,
    String? fullName,
  }) async {
    try {
      const url = "/profile/info";
      Map<String, String> data = {};
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
      return ProfileResponseModel.fromJson(response.data['data']);
    } on DioError catch (e) {
      throw ResponseException(
          statusCode: e.response?.statusCode,
          message: e.response?.data?["msg"] ?? exception);
    }
  }

  FutureOr<ProfileResponseModel> uploadAvatar({
    required String token,
    required List<int> avatar,
  }) async {
    try {
      const url = "/profile/avatar";

      var data = FormData.fromMap({
        'avatar': MultipartFile.fromBytes(
          avatar,
          filename: "image.png",
          contentType: MediaType.parse('image/jpeg'),
        ),
      });

      var response = await dio.put(
        url,
        options: Options(
          headers: headerMultiFormData(token: token),
        ),
        data: data,
      );
      return ProfileResponseModel.fromJson(response.data['data']);
    } on DioError catch (e) {
      throw ResponseException(
          statusCode: e.response?.statusCode,
          message: e.response?.data?["msg"] ?? exception);
    }
  }

  FutureOr<bool> changePassword({
    required String token,
    required String password,
    required String newPassword,
  }) async {
    try {
      const url = "/profile/changePassword";

      var data = {
        'password': password,
        'newPassword': newPassword,
      };

      var response = await dio.post(
        url,
        options: Options(
          headers: headerApplicationJson(token: token),
        ),
        data: data,
      );
      return response.statusCode == 200 ? true : false;
    } on DioError catch (e) {
      throw ResponseException(
          statusCode: e.response?.statusCode,
          message: e.response?.data?["msg"] ?? exception);
    }
  }

  FutureOr<ProfileResponseModel> followUser({
    required String token,
    required String followId,
  }) async {
    try {
      final url = "/profile/follow/$followId";

      var response = await dio.put(
        url,
        options: Options(
          headers: headerApplicationJson(token: token),
        ),
      );
      return ProfileResponseModel.fromJson(response.data['data']);
    } on DioError catch (e) {
      throw ResponseException(
          statusCode: e.response?.statusCode,
          message: e.response?.data?["msg"] ?? exception);
    }
  }

  FutureOr<ProfilesResponseModel> searchProfile(
      String token, String query) async {
    const url = "/profile/search";
    var data = {
      "fullName": query,
    };
    try {
      var response = await dio.get(
        url,
        options: Options(
          headers: headerApplicationJson(token: token),
        ),
        data: data,
      );
      return ProfilesResponseModel.fromJson(response.data['data']);
    } on DioError catch (e) {
      throw ResponseException(
          statusCode: e.response?.statusCode,
          message: e.response?.data?["msg"] ?? exception);
    }
  }
}
