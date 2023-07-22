import 'package:musix/domain_social/models/post/request/report_post_request_model.dart';

abstract class IReportPostRepo {
  Future<bool> createNewReport(
      ReportPostRequestModel reportPostRequestModel, String token);
}
