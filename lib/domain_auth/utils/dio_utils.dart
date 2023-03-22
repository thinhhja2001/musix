///By default, if the status code is not 200, Dio will throw a DioError
///
///Adding this function to DioOption to avoid that exception
bool validateStatus(int? statusCode) {
  if (statusCode == null) return false;
  return true;
}
