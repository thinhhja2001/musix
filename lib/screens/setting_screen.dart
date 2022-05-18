
import 'package:flutter/material.dart';
import 'package:musix/models/users.dart';
import 'package:musix/utils/colors.dart';

import '../widgets/profile/profile_body.dart';

class ProfileSetting extends StatelessWidget {
  const ProfileSetting({ Key? key,required this.user }) : super(key: key);
  final Users user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(centerTitle: true,title: const Text("Profile"),backgroundColor: kBackgroundColorDarker,),
      body: ProfileBody(user: user),
    );
  }
}