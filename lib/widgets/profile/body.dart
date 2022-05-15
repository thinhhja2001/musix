import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musix/models/users.dart';
import 'package:musix/utils/colors.dart';
import 'package:musix/utils/constant.dart';
import 'package:musix/widgets/profile/Profile_fix.dart';
import 'package:musix/widgets/profile/profile_pic.dart';

import '../music_selection_widget.dart';

class Body extends StatelessWidget {
  const Body({Key? key, required this.user}) : super(key: key);
  final Users user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          width: double.infinity,
          height: 20,
        ),
        ProfilePic(
          avatarUrl: user.avatarUrl,
        ),
        const SizedBox(
          width: double.infinity,
          height: 10,
        ),
        Text(
          user.username,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16),
        ),
        Text(
          user.email,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16),
        ),
        TextButton(
            onPressed: () {
              Get.to(FixProfile(
                user: user,
              ));
            },
            child: const Text(
              "Change your information",
              style: TextStyle(color: kPrimaryColor),
            )),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: const [
                Text(
                  "5",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                Text(
                  "Follower",
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Column(
              children: const [
                Text(
                  "20",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                Text(
                  "Following",
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 40,
        ),
        Container(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              const RotatedBox(
                quarterTurns: -1,
                child: Text(
                  "Recent Music",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w300),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 5,
                        itemBuilder: (context, position) =>
                            MusicSelectionWidget(
                              index: position,
                              song: fakeSongsData[position],
                            )),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
