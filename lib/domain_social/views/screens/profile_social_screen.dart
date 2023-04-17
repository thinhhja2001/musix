import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:musix/domain_auth/views/widgets/custom_button_widget.dart';
import 'package:musix/domain_social/views/widgets/posts/social_data_player_widget.dart';
import 'package:musix/theme/color.dart';
import 'package:musix/theme/text_style.dart';

class ProfileSocialScreen extends StatelessWidget {
  const ProfileSocialScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nen goi la Rex"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: const Icon(Icons.arrow_back_ios),
      ),
      backgroundColor: ColorTheme.backgroundDarker,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(
                      "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=80"),
                ),
                Text(
                  "@thinhhja2001",
                  style: TextStyleTheme.ts18.copyWith(color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          '14',
                          style: TextStyleTheme.ts14.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Following",
                          style: TextStyleTheme.ts12
                              .copyWith(color: const Color(0xff86878B)),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '1.9K',
                          style: TextStyleTheme.ts14.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Followers",
                          style: TextStyleTheme.ts12
                              .copyWith(color: const Color(0xff86878B)),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '46K',
                          style: TextStyleTheme.ts14.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Likes",
                          style: TextStyleTheme.ts12
                              .copyWith(color: const Color(0xff86878B)),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomButtonWidget(
                            onPress: () {}, content: "Follow"),
                      ),
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey)),
                            child: const Icon(
                              FontAwesomeIcons.instagram,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey)),
                            child: const Icon(
                              Icons.arrow_drop_down,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Never lose hope \nAdditional profile information",
                  style: TextStyleTheme.ts16.copyWith(color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          SliverGrid.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5),
              itemCount: 10,
              itemBuilder: (context, index) => const SocialDataPlayerWidget(
                  dataUrl:
                      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
                  title: "laksnf",
                  artistName: "laksnf",
                  thumbnailUrl:
                      "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=80"))
        ],
      ),
    );
  }
}
