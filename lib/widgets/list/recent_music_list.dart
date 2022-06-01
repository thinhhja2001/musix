import 'package:flutter/material.dart';
import 'package:musix/widgets/music/song/list_song_widget.dart';
import 'package:musix/widgets/music/song/music_selection_widget.dart';

import '../../resources/song_methods.dart';
import '../../utils/colors.dart';
import '../../utils/constant.dart';

class RecentMusicList extends StatelessWidget {
  const RecentMusicList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: SafeArea(
      child: Row(
        children: [
          const RotatedBox(
              quarterTurns: 3,
              child: Text(
                "Recently Music",
                style: kDefaultTitleStyle,
              )),
          Expanded(
            child: StreamBuilder<List<String>>(
                stream: Stream.fromFuture(
                    SongMethods.getRecentListenedSong(quantity: 5)),
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
    ));
  }
}
