import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:musix/apis/zing_mp3_api.dart';
import 'package:musix/models/album.dart';
import 'package:musix/models/users.dart';
import 'package:musix/resources/general_music_methods.dart';
import 'package:musix/resources/playlist_methods.dart';
import 'package:musix/utils/constant.dart';
import 'package:musix/utils/utils.dart';
import 'package:musix/widgets/home/profile_card.dart';
import 'package:musix/widgets/list/your_favorite_list.dart';
import 'package:musix/widgets/music/album/album_card.dart';
import 'package:musix/widgets/music/other/music_type_seclection_widget.dart';

class ExploreWidget extends StatelessWidget {
  const ExploreWidget({
    Key? key,
    required this.user,
  }) : super(key: key);
  final Users user;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      buildBlurredImage(),
      SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.05,
            left: MediaQuery.of(context).size.width * 0.05,
            right: MediaQuery.of(context).size.width * 0.05,
          ),
          child: CustomScrollView(
            primary: false,
            slivers: [
              ProfileCard(user: user),
              verticalSliverPaddingMedium,
              const MusicTypeSelectionWidget(),
              verticalSliverPaddingMedium,
              SliverToBoxAdapter(
                child: Row(
                  children: const [
                    RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          'Your Favorite',
                          style: kDefaultTitleStyle,
                        )),
                    YourFavoriteListWidget(),
                  ],
                ),
              )
            ],
          ),
        ),
      )
    ]);
  }
}
