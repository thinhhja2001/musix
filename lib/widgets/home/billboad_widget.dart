import 'package:flutter/material.dart';
import 'package:musix/widgets/home/profile_card.dart';

import '../../models/users.dart';
import '../../utils/constant.dart';
import '../../utils/utils.dart';
import '../list/new_album_list.dart';
import '../list/recent_music_list.dart';
import '../video_player/weekly_music_widget.dart';

class BillboardWidget extends StatelessWidget {
  const BillboardWidget({
    Key? key,
    required this.user,
  }) : super(key: key);
  final Users user;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildBlurredImage(),
        verticalSpaceLarge,
        SafeArea(
            child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.05,
            left: MediaQuery.of(context).size.width * 0.05,
            right: MediaQuery.of(context).size.width * 0.05,
          ),
          child: CustomScrollView(
            slivers: [
              ProfileCard(user: user),
              verticalSliverPaddingMedium,
              const NewAlbumList(),
              verticalSliverPaddingMedium,
              const WeeklyMusicWidget(),
              verticalSliverPaddingMedium,
              const RecentMusicList(),
              verticalSliverPaddingMedium,
              verticalSliverPaddingMedium
            ],
          ),
        )),
      ],
    );
  }
}
