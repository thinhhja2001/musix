import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:musix/resources/general_music_methods.dart';
import 'package:musix/resources/playlist_methods.dart';
import 'package:musix/utils/constant.dart';
import 'package:musix/widgets/music/album/album_card/album_card_from_album_data.dart';

class ListFavoriteSongsWidget extends StatelessWidget {
  const ListFavoriteSongsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: GeneralMusicMethods.getAllFavoriteObject(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final album = PlaylistMethods.getFavoriteSongPlaylist(snapshot.data!);
          return AlbumCardFromAlbumData(album: album);
        }
        return AlbumCardFromAlbumData(album: albumWithNoData);
      },
    );
  }
}
