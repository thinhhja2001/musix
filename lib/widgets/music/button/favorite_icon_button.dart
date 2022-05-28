import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:musix/resources/general_music_methods.dart';
import 'package:musix/resources/song_methods.dart';
import 'package:provider/provider.dart';

import '../../../providers/audio_player_provider.dart';
import '../../../utils/colors.dart';

class FavoriteIconButton extends StatelessWidget {
  const FavoriteIconButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AudioPlayerProvider audioPlayerProvider =
        Provider.of<AudioPlayerProvider>(context);

    return StreamBuilder<DocumentSnapshot>(
        stream: GeneralMusicMethods.getAllFavoriteObject(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final songs = snapshot.data!.get('songs');
            return IconButton(
                onPressed: () => {
                      SongMethods.onFavoriteSongClickHandler(
                          audioPlayerProvider.currentSong),
                    },
                icon: Icon(
                  songs.contains(audioPlayerProvider.currentSong.id)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: songs.contains(audioPlayerProvider.currentSong.id)
                      ? kPrimaryColor
                      : Colors.white,
                ));
          } else {
            return Container();
          }
        });
  }
}
