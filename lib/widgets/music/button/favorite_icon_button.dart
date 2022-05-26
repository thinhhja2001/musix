import 'package:flutter/material.dart';
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

    return FutureBuilder<List>(
        future: SongMethods.getAllFavoriteSong(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return IconButton(
                onPressed: () => {
                      SongMethods.onFavoriteSongClickHandler(
                          audioPlayerProvider.currentSong),
                      print(snapshot.data!
                          .contains(audioPlayerProvider.currentSong.id))
                    },
                icon: Icon(
                  snapshot.data!.contains(audioPlayerProvider.currentSong.id)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: snapshot.data!
                          .contains(audioPlayerProvider.currentSong.id)
                      ? kPrimaryColor
                      : Colors.white,
                ));
          } else {
            return Container();
          }
        });
  }
}
