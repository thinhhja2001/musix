import 'package:flutter/material.dart';
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
            child: FutureBuilder(
              future: SongMethods.getListSongDataByKeys(fakeSongsData),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, position) =>
                              MusicSelectionWidget(
                                index: position,
                                song: snapshot.data[position],
                              )),
                    ],
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
    ));
  }
}
