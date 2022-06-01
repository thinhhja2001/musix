import 'package:flutter/material.dart';
import 'package:musix/models/album.dart';
import 'package:musix/resources/playlist_methods.dart';
import 'package:musix/utils/constant.dart';
import 'package:musix/widgets/music/album/album_card/album_card_from_album_data.dart';

class YourPlaylistWidget extends StatelessWidget {
  const YourPlaylistWidget({
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
                'Your Playlists',
                style: kDefaultTitleStyle,
              )),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: FutureBuilder<List<Album>>(
                future: PlaylistMethods.getAllAlbumOfCurrentUser(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Row(
                      children: List.generate(
                          snapshot.data!.length,
                          (index) => AlbumCardFromAlbumData(
                              album: snapshot.data!.elementAt(index))),
                    );
                  }
                  return Container();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
