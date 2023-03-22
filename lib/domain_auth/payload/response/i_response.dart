// ignore_for_file: public_member_api_docs, sort_constructors_first

abstract class IResponse {
  int status;
  String msg;
  Map<String, dynamic>? data;
  IResponse({
    required this.status,
    required this.msg,
    this.data,
  });
}
