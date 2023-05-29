class CopyrightCheckerResponseModel {
  int statusCode;
  bool result;
  String message;

  CopyrightCheckerResponseModel({
    required this.statusCode,
    required this.result,
    required this.message,
  });

  factory CopyrightCheckerResponseModel.fromJson(Map<String, dynamic> json) =>
      CopyrightCheckerResponseModel(
        statusCode: json['status_code'],
        result: json['result'],
        message: json['message'],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "result": result,
        "message": message,
      };
}
