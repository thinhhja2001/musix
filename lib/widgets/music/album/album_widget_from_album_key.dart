import 'package:flutter/material.dart';
import 'package:musix/apis/zing_mp3_api.dart';
import 'package:musix/models/album.dart';
import 'package:musix/resources/playlist_methods.dart';
import 'package:musix/utils/constant.dart';
import 'package:musix/utils/utils.dart';
import 'package:musix/widgets/music/album/album_card/album_card_from_album_data.dart';
import 'package:musix/widgets/music/album/album_card/album_card_from_json.dart';

class AlbumWidgetFromAlbumKey extends StatelessWidget {
  const AlbumWidgetFromAlbumKey({
    Key? key,
    required this.albumKey,
  }) : super(key: key);

  final String albumKey;

  @override
  Widget build(BuildContext context) {
    return isOfficialAlbum(albumKey)
        ? _OfficialAlbumWidget(albumKey: albumKey)
        : _UnofficialAlbumWidget(albumKey: albumKey);
  }
}

class _UnofficialAlbumWidget extends StatelessWidget {
  const _UnofficialAlbumWidget({
    Key? key,
    required this.albumKey,
  }) : super(key: key);

  final String albumKey;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Album>(
      future: PlaylistMethods.getAlbumDataByKey(albumKey),
      builder: (context, albumSnapshot) {
        if (albumSnapshot.hasData) {
          return AlbumCardFromAlbumData(album: albumSnapshot.data!);
        }
        return AlbumCardFromAlbumData(album: albumWithNoData);
      },
    );
  }
}

class _OfficialAlbumWidget extends StatelessWidget {
  const _OfficialAlbumWidget({
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
          return AlbumCardFromAlbumData(album: album);
        }
        return AlbumCardFromAlbumData(album: albumWithNoData);
      },
    );
  }
}
