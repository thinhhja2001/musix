import 'package:dio/dio.dart';
import 'package:musix/config/exporter/environment_exporter.dart';
import 'package:musix/domain_social/models/copyright_checker/copyright_checker_request_model.dart';
import 'package:musix/domain_social/models/copyright_checker/copyright_checker_response_model.dart';
import 'package:musix/domain_social/repository/copyright_checker/i_copyright_checker_repo.dart';
import 'package:musix/global/repo/initial_repo.dart';

class CopyrightCheckerRepo extends InitialRepo
    implements ICopyrightCheckerRepo {
  final String databaseUrl = Environment.recommendationServerUrl;
  @override
  Future<CopyrightCheckerResponseModel> checkCopyright(
      CopyrightCheckerRequestModel copyrightCheckerRequestModel) async {
    var data = FormData.fromMap({
      "song_file":
          MultipartFile.fromFileSync(copyrightCheckerRequestModel.song.path)
    });
    final response = await dio.get("$databaseUrl/check_copyright", data: data);
    return CopyrightCheckerResponseModel.fromJson(response.data);
  }
}
