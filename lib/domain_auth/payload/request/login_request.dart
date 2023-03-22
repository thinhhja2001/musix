class LoginRequest {
  String username;
  String password;
  LoginRequest({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'username': username,
      'password': password,
    };
  }

  factory LoginRequest.fromJson(Map<String, dynamic> map) {
    return LoginRequest(
      username: map['username'] as String,
      password: map['password'] as String,
    );
  }
}
