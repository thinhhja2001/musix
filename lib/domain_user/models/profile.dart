// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:intl/intl.dart';

class Profile {
  String fullName;
  DateTime birthday;
  String? avatarUri;
  String phoneNumber;
  Profile({
    required this.fullName,
    required this.birthday,
    this.avatarUri,
    required this.phoneNumber,
  });

  Profile copyWith({
    String? fullName,
    DateTime? birthday,
    String? avatarUri,
    String? phoneNumber,
  }) {
    return Profile(
      fullName: fullName ?? this.fullName,
      birthday: birthday ?? this.birthday,
      avatarUri: avatarUri ?? this.avatarUri,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'fullName': fullName,
      'birthday': birthday.millisecondsSinceEpoch,
      'avatarUri': avatarUri,
      'phoneNumber': phoneNumber,
    };
  }

  factory Profile.fromJson(Map<String, dynamic> map) {
    return Profile(
      fullName: map['fullName'] as String,
      birthday: DateFormat("dd/MM/yyyy").parse(map['birthday'] as String),
      avatarUri: map['avatarUri'] != null ? map['avatarUri'] as String : null,
      phoneNumber: map['phoneNumber'] as String,
    );
  }
}
