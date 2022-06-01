import 'package:flutter/material.dart';
import 'package:musix/models/album.dart';
import 'package:musix/resources/playlist_methods.dart';
import 'package:musix/utils/constant.dart';
import 'package:musix/widgets/music/album/album_card/album_card_from_album_data.dart';

class AlbumCardFromAlbumKey extends StatelessWidget {
  const AlbumCardFromAlbumKey({
    Key? key,
    required this.albumKey,
  }) : super(key: key);

  final String albumKey;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Album>(
      future: PlaylistMethods.getAlbumDataByKey(albumKey),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return AlbumCardFromAlbumData(album: snapshot.data!);
        }

        return AlbumCardFromAlbumData(
          album: albumWithNoData,
        );
      },
    );
  }
}
