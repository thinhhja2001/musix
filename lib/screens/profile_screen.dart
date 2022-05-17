import 'package:flutter/material.dart';
import 'package:musix/utils/colors.dart';
import 'package:musix/utils/constant.dart';
import 'package:musix/widgets/profile/icon_text.dart';

import '../resources/music_methods.dart';
import '../widgets/music/music_selection_widget.dart';
import '../widgets/music/music_selection_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xCC000000),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Material(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.black,
            child: Column(
              children: [
                Stack(
                  children: <Widget>[
                    Image(
                      fit: BoxFit.cover,
                      image: const AssetImage("assets/images/profile-img.png"),
                      height: MediaQuery.of(context).size.width,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.width,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.center,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0x00000000),
                            Color(0xCC000000),
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, bottom: 20),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "James Smith",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                "02 Jan 1992",
                                style: TextStyle(
                                    color: kPrimaryColor, fontSize: 12),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                child: const Text(
                                  "Setting",
                                  style: TextStyle(
                                      color: kPrimaryColor, fontSize: 16),
                                ),
                                style: ElevatedButton.styleFrom(
                                    primary: kBackgroundColorDarker),
                              ),
                            ]),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 220,
                  width: 400,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "My library",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              fontFamily: "SF Pro Text"),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: double.infinity * 0.8,
                        child: TextButton(
                          onPressed: () {},
                          child: const Align(
                            alignment: Alignment.centerLeft,
                            child: IconText(
                              icon: Icons.music_note,
                              text: "My playlist",
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity * 0.8,
                        child: TextButton(
                          onPressed: () {},
                          child: const Align(
                            alignment: Alignment.centerLeft,
                            child: IconText(
                              icon: Icons.album,
                              text: "Album",
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity * 0.8,
                        child: TextButton(
                          onPressed: () {},
                          child: const Align(
                            alignment: Alignment.centerLeft,
                            child: IconText(
                              icon: Icons.person_outline,
                              text: "Following",
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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
                        child: FutureBuilder(
                          future:
                              MusicMethods.getListSongDataByKeys(fakeSongsData),
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.hasData) {
                              return Expanded(
                                child: Column(
                                  children: [
                                    ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: 5,
                                        itemBuilder: (context, position) =>
                                            MusicSelectionWidget(
                                              index: position,
                                              song: snapshot.data[position],
                                            )),
                                  ],
                                ),
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: kPrimaryColor,
                                ),
                              );
                            }
                          },
                        ),
                      )
                    ],
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
