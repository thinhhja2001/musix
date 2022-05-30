import 'package:flutter/material.dart';
import 'package:musix/resources/playlist_methods.dart';
import 'package:musix/resources/song_methods.dart';
import 'package:musix/utils/colors.dart';

import '../../utils/constant.dart';
import '../music/album/album_card.dart';

class YouMayLoveList extends StatelessWidget {
  const YouMayLoveList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextButton(
              onPressed: () {},
              child: Text(
                "View all",
                style: kDefaultTitleStyle.copyWith(
                  color: kPrimaryColor,
                ),
              )),
          Row(
            children: [
              const RotatedBox(
                quarterTurns: 3,
                child: Text(
                  "You may love",
                  style: kDefaultTitleStyle,
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: PlaylistMethods.getListAlbumByArtists(
                      fakeFavoriteArtists),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            children: List.generate(
                                snapshot.data.length,
                                (index) => AlbumCard(
                                      album: snapshot.data[index],
                                    ))),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(color: kPrimaryColor),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
