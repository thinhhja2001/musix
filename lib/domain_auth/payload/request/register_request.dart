class RegisterRequest {
  String username;
  String fullName;
  String email;
  String password;
  String birthday;
  String phoneNumber;
  RegisterRequest({
    required this.username,
    required this.fullName,
    required this.email,
    required this.password,
    required this.birthday,
    required this.phoneNumber,
  });

  RegisterRequest copyWith({
    String? username,
    String? fullName,
    String? email,
    String? password,
    String? birthday,
    String? phoneNumber,
  }) {
    return RegisterRequest(
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      birthday: birthday ?? this.birthday,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'username': username,
      'fullName': fullName,
      'email': email,
      'password': password,
      'birthday': birthday,
      'phoneNumber': phoneNumber,
    };
  }

  factory RegisterRequest.fromJson(Map<String, dynamic> map) {
    return RegisterRequest(
      username: map['username'] as String,
      fullName: map['fullName'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      birthday: map['birthday'] as String,
      phoneNumber: map['phoneNumber'] as String,
    );
  }
}
