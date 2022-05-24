import 'package:flutter/material.dart';
import 'package:musix/apis/zing_mp3_api.dart';
import 'package:musix/models/album.dart';
import 'package:musix/widgets/music/album/album_card.dart';

import '../../utils/constant.dart';
import '../../utils/utils.dart';

class WeeklyAlbumWidget extends StatelessWidget {
  const WeeklyAlbumWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        children: [
          const RotatedBox(
            quarterTurns: 3,
            child: Text(
              "Weekly",
              style: kDefaultTitleStyle,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                FutureBuilder(
                  future: Album.topSongVietnam(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      return AlbumCard(
                        album: snapshot.data,
                      );
                    } else {
                      return noAlbumData(context);
                    }
                  },
                ),
                FutureBuilder(
                  future: Album.topSongUSUK(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      return AlbumCard(
                        album: snapshot.data,
                      );
                    } else {
                      return noAlbumData(context);
                    }
                  },
                ),
                FutureBuilder(
                  future: Album.topSongKPOP(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      return AlbumCard(
                        album: snapshot.data,
                      );
                    } else {
                      return noAlbumData(context);
                    }
                  },
                )
              ]),
            ),
          )
        ],
      ),
    );
  }
}
