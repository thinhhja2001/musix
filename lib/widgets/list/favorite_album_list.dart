import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:musix/resources/general_music_methods.dart';
import 'package:musix/widgets/music/album/album_widget_from_album_key.dart';

class ListFavoriteAlbumsWidget extends StatelessWidget {
  const ListFavoriteAlbumsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: GeneralMusicMethods.getAllFavoriteObject(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final favoriteAlbums = snapshot.data!.get('albums');
          return Row(
            children: List.generate(favoriteAlbums.length, (index) {
              return AlbumWidgetFromAlbumKey(albumKey: favoriteAlbums[index]);
            }),
          );
        }
        return Container();
      },
    );
  }
}
