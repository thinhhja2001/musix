import 'package:flutter/material.dart';
import 'package:musix/widgets/video_player/asset_player_widget.dart';

import '../../utils/constant.dart';

class WeeklyMusicWidget extends StatelessWidget {
  const WeeklyMusicWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        children: const [
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              "Weekly",
              style: kDefaultTitleStyle,
            ),
          ),
          AssetPlayerWidget()
        ],
      ),
    );
  }
}
