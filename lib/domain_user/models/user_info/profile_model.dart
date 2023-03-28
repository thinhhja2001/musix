// ignore_for_file: public_member_api_docs, sort_constructors_first

class ProfileModel {
  String fullName;
  String birthday;
  String? avatarUri;
  String phoneNumber;
  ProfileModel({
    required this.fullName,
    required this.birthday,
    this.avatarUri,
    required this.phoneNumber,
  });

  ProfileModel copyWith({
    String? fullName,
    String? birthday,
    String? avatarUri,
    String? phoneNumber,
  }) {
    return ProfileModel(
      fullName: fullName ?? this.fullName,
      birthday: birthday ?? this.birthday,
      avatarUri: avatarUri ?? this.avatarUri,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'fullName': fullName,
      'birthday': birthday,
      'avatarUri': avatarUri,
      'phoneNumber': phoneNumber,
    };
  }

  factory ProfileModel.fromJson(Map<String, dynamic> map) {
    return ProfileModel(
      fullName: map['fullName'] as String,
      birthday: map['birthday'] as String,
      avatarUri: map['avatarUri'] != null ? map['avatarUri'] as String : null,
      phoneNumber: map['phoneNumber'] as String,
    );
  }
}
