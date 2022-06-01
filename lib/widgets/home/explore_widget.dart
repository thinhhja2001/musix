import 'package:flutter/material.dart';
import 'package:musix/models/album.dart';
import 'package:musix/models/users.dart';
import 'package:musix/resources/playlist_methods.dart';
import 'package:musix/utils/constant.dart';
import 'package:musix/utils/utils.dart';
import 'package:musix/widgets/home/profile_card.dart';
import 'package:musix/widgets/music/album/album_card/album_card_from_album_data.dart';
import 'package:musix/widgets/music/other/keep_play_back_widget.dart';
import 'package:musix/widgets/music/other/music_type_selection_widget.dart';
import 'package:musix/widgets/music/other/your_favorite_widget.dart';
import 'package:musix/widgets/music/other/your_playlist_widget.dart';

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
              const YourFavoriteWidget(),
              verticalSliverPaddingMedium,
              const KeepPlaybackWidget(),
              verticalSliverPaddingMedium,
              const YourPlaylistWidget(),
              verticalSliverPaddingMedium,
              verticalSliverPaddingMedium,
              verticalSliverPaddingMedium,
            ],
          ),
        ),
      )
    ]);
  }
}
