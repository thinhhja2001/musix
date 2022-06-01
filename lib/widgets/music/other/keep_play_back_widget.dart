import 'package:flutter/material.dart';
import 'package:musix/models/album.dart';
import 'package:musix/resources/playlist_methods.dart';
import 'package:musix/widgets/music/album/album_card/album_card_from_album_data.dart';
import 'package:musix/widgets/music/album/album_card/album_card_from_album_key.dart';

import '../../../utils/constant.dart';

class KeepPlaybackWidget extends StatelessWidget {
  const KeepPlaybackWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(children: [
        const RotatedBox(
            quarterTurns: 3,
            child: Text(
              'Keep Playback',
              style: kDefaultTitleStyle,
            )),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                FutureBuilder<Album>(
                  future: PlaylistMethods.getTopListenTimeSongPlaylist(
                      quantity: 50),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return AlbumCardFromAlbumData(album: snapshot.data!);
                    }
                    return AlbumCardFromAlbumData(album: albumWithNoData);
                  },
                ),
                FutureBuilder<List>(
                  future: PlaylistMethods.getTopListenedAlbumOrderByListenTime(
                      quantity: 50),
                  builder: (context, albumSnapshot) {
                    if (albumSnapshot.hasData) {
                      return Row(
                        children: List.generate(
                            albumSnapshot.data!.length,
                            (index) => AlbumCardFromAlbumKey(
                                albumKey:
                                    albumSnapshot.data!.elementAt(index))),
                      );
                    }
                    return AlbumCardFromAlbumData(album: albumWithNoData);
                  },
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
