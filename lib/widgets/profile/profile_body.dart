import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musix/models/users.dart';
import 'package:musix/resources/song_methods.dart';
import 'package:musix/resources/profile_methods.dart';
import 'package:musix/screens/signin_screen.dart';
import 'package:musix/utils/colors.dart';
import 'package:musix/utils/constant.dart';
import 'package:musix/screens/Profile_fix_screen.dart';
import 'package:musix/widgets/music/song/list_song_widget.dart';
import 'package:musix/widgets/music/song/music_selection_widget.dart';
import 'package:musix/widgets/profile/profile_pic.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({Key? key, required this.user}) : super(key: key);
  final Users user;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
                    quarterTurns: 3,
                    child: Text(
                      "Recently Music",
                      style: kDefaultTitleStyle,
                    )),
                Expanded(
                  child: FutureBuilder<List<String>>(
                      future: SongMethods.getRecentListenedSong(quantity: 5),
                      builder: (context, songData) {
                        if (songData.hasData) {
                          return ListSongWidget(
                            songsKey: songData.data!,
                          );
                        }
                        return Container();
                      }),
                )
              ],
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
                textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(
                    color: Colors.red, fontWeight: FontWeight.bold)),
                backgroundColor:
                    MaterialStateProperty.all<Color>(kPrimaryColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ))),
            onPressed: () async {
              await ProfileMethods()
                  .signOut()
                  .then((value) => Get.offAll(const SignInScreen()));
            },
            child: const Text("Log out"),
          )
        ],
      ),
    );
  }
}
