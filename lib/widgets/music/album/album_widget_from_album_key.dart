import 'package:flutter/material.dart';
import 'package:musix/apis/zing_mp3_api.dart';
import 'package:musix/models/album.dart';
import 'package:musix/utils/constant.dart';
import 'package:musix/widgets/music/album/album_card.dart';

class AlbumWidgetFromAlbumKey extends StatelessWidget {
  const AlbumWidgetFromAlbumKey({
    Key? key,
    required this.albumKey,
  }) : super(key: key);

  final String albumKey;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: ZingMP3API.getAlbumDataByKey(albumKey),
      builder: (context, albumSnapshot) {
        if (albumSnapshot.hasData) {
          final album = Album.fromJson(albumSnapshot.data!);
          return AlbumCard(album: album);
        }
        return AlbumCard(album: albumWithNoData);
      },
    );
  }
}
