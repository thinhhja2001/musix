import 'package:flutter/material.dart';
import 'package:musix/apis/zing_mp3_api.dart';
import 'package:musix/models/album.dart';
import 'package:musix/widgets/music/album_card.dart';

import '../../utils/constant.dart';

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
                      return _noAlbumData(context);
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
                      return _noAlbumData(context);
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
                      return _noAlbumData(context);
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

  Widget _noAlbumData(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Container(
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.width / 2,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                  fit: BoxFit.fill, image: NetworkImage(noImageUrl)))),
    );
  }
}
