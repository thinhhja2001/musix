// ignore_for_file: public_member_api_docs, sort_constructors_first

class ResetPasswordRequest {
  String token;
  String email;
  String newPassword;
  ResetPasswordRequest({
    required this.token,
    required this.email,
    required this.newPassword,
  });

  ResetPasswordRequest copyWith({
    String? token,
    String? email,
    String? newPassword,
  }) {
    return ResetPasswordRequest(
      token: token ?? this.token,
      email: email ?? this.email,
      newPassword: newPassword ?? this.newPassword,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'token': token,
      'email': email,
      'newPassword': newPassword,
    };
  }

  factory ResetPasswordRequest.fromJson(Map<String, dynamic> map) {
    return ResetPasswordRequest(
      token: map['token'] as String,
      email: map['email'] as String,
      newPassword: map['newPassword'] as String,
    );
  }
}
