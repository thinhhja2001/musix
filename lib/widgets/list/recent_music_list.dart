import 'package:flutter/material.dart';
import 'package:musix/widgets/music_selection_widget.dart';

import '../../utils/constant.dart';

class RecentMusicList extends StatelessWidget {
  const RecentMusicList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const RotatedBox(
            quarterTurns: 3,
            child: Text(
              "Recently Music",
              style: kDefaultTitleStyle,
            )),
        Expanded(
          child: Column(
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, position) => MusicSelectionWidget(
                        index: position,
                      )),
            ],
          ),
        )
      ],
    ));
  }
}
