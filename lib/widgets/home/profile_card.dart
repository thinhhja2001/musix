import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musix/screens/setting_screen.dart';

import '../../models/users.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
    required this.user,
  }) : super(key: key);
  final Users user;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: () {
          Get.to(ProfileSetting(user: user));
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.36),
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  user.username,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400),
                ),
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                    user.avatarUrl,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
