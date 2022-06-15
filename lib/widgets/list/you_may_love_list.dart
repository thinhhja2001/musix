import 'package:flutter/material.dart';
import 'package:musix/resources/artist_methods.dart';
import 'package:musix/resources/playlist_methods.dart';
import 'package:musix/utils/colors.dart';
import 'package:musix/widgets/music/album/album_card/album_card_from_album_data.dart';

import '../../utils/constant.dart';

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
                child: FutureBuilder<List>(
                    future: ArtistMethods.getTop10FavoriteArtists(),
                    builder: (context, artistSnapshot) {
                      if (artistSnapshot.hasData) {
                        return FutureBuilder(
                          future: PlaylistMethods.getListAlbumByArtists(
                              artistSnapshot.data!),
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.hasData) {
                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                    children: List.generate(
                                        snapshot.data.length,
                                        (index) => AlbumCardFromAlbumData(
                                              album: snapshot.data[index],
                                            ))),
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(
                                    color: kPrimaryColor),
                              );
                            }
                          },
                        );
                      }
                      return Container();
                    }),
              )
            ],
          ),
        ],
      ),
    );
  }
}
