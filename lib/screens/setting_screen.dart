
import 'package:flutter/material.dart';
import 'package:musix/utils/colors.dart';

import '../widgets/profile/body.dart';

class ProfileSetting extends StatelessWidget {
  const ProfileSetting({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(centerTitle: true,title: Text("Profile"),backgroundColor: kBackgroundColorDarker,),
      body: Body(),
    );
  }
}