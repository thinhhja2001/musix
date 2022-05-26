import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:musix/providers/album_provider.dart';
import 'package:musix/resources/general_music_methods.dart';
import 'package:musix/resources/playlist_methods.dart';
import 'package:musix/utils/colors.dart';
import 'package:provider/provider.dart';

class AddAlbumToFavoriteIconButton extends StatelessWidget {
  const AddAlbumToFavoriteIconButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AlbumProvider albumProvider = Provider.of<AlbumProvider>(context);

    return StreamBuilder<DocumentSnapshot>(
        stream: GeneralMusicMethods.getAllFavoriteObject(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final albums = snapshot.data!.get('albums');
            return IconButton(
              onPressed: () => {
                PlaylistMethods.onFavoriteAlbumClickHandler(
                    albumProvider.currentAlbum),
              },
              icon: Icon(
                  albums.contains(albumProvider.currentAlbum.id)
                      ? Icons.favorite
                      : Icons.favorite_outline,
                  color: albums.contains(albumProvider.currentAlbum.id)
                      ? kPrimaryColor
                      : Colors.white),
            );
          }
          return Container();
        });
  }
}
