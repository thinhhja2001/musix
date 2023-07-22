import 'package:dio/dio.dart';
import 'package:musix/domain_social/models/post/request/report_post_request_model.dart';
import 'package:musix/global/repo/initial_repo.dart';

import 'i_report_post_repo.dart';

class ReportPostRepo extends InitialRepo implements IReportPostRepo {
  final _baseUrl = "/social/report-post";

  @override
  Future<bool> createNewReport(
      ReportPostRequestModel reportPostRequestModel, String token) async {
    try {
      var response = await dio.post(_baseUrl,
          data: {
            "postId": reportPostRequestModel.postId,
            "userId": reportPostRequestModel.userId,
            "reason": reportPostRequestModel.reason
          },
          options: Options(headers: headerApplicationJson(token: token)));
      if (response.statusCode == 200) return true;
      return false;
    } catch (e) {
      print("error occured $e");
      return false;
    }
  }
}
