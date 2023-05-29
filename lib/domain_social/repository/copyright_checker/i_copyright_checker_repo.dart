import 'package:musix/domain_social/models/copyright_checker/copyright_checker_request_model.dart';
import 'package:musix/domain_social/models/copyright_checker/copyright_checker_response_model.dart';

abstract class ICopyrightCheckerRepo {
  Future<CopyrightCheckerResponseModel> checkCopyright(
      CopyrightCheckerRequestModel copyrightCheckerRequestModel);
}
