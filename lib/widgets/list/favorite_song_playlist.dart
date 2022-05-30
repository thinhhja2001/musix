import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:musix/resources/general_music_methods.dart';
import 'package:musix/resources/playlist_methods.dart';
import 'package:musix/utils/constant.dart';
import 'package:musix/widgets/music/album/album_card.dart';

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
          return AlbumCard(album: album);
        }
        return AlbumCard(album: albumWithNoData);
      },
    );
  }
}
