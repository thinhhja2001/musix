import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  final String? phoneNumber;
  final String? fullName;
  final String? birthday;
  final String? avatarUrl;

  const Profile({
    this.fullName,
    this.phoneNumber,
    this.birthday,
    this.avatarUrl,
  });

  Profile copyWith({
    String? birthday,
    String? fullName,
    String? phoneNumber,
    String? avatarUrl,
  }) {
    return Profile(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      fullName: fullName ?? this.fullName,
      birthday: birthday ?? this.birthday,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  @override
  List<Object?> get props => [
        birthday,
        fullName,
        phoneNumber,
        avatarUrl,
      ];

  @override
  bool? get stringify => true;
}
