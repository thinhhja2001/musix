import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:musix/models/album.dart';
import 'package:musix/providers/audio_player_provider.dart';
import 'package:musix/resources/general_music_methods.dart';
import 'package:musix/resources/playlist_methods.dart';
import 'package:musix/utils/colors.dart';
import 'package:provider/provider.dart';

class AddAlbumToFavoriteIconButton extends StatelessWidget {
  const AddAlbumToFavoriteIconButton({
    Key? key,
    required this.album,
  }) : super(key: key);
  final Album album;
  @override
  Widget build(BuildContext context) {
    final audioPlayerProvider = Provider.of<AudioPlayerProvider>(context);

    return StreamBuilder<DocumentSnapshot>(
        stream: GeneralMusicMethods.getAllFavoriteObject(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final albums = snapshot.data!.get('albums');
            return IconButton(
              onPressed: () => {
                PlaylistMethods.onFavoriteAlbumClickHandler(album),
              },
              icon: Icon(
                  albums.contains(album.id)
                      ? Icons.favorite
                      : Icons.favorite_outline,
                  color:
                      albums.contains(album.id) ? kPrimaryColor : Colors.white),
            );
          }

          return Container();
        });
  }
}
