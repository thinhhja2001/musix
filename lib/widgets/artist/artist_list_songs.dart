import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/artist_provider.dart';
import '../../providers/audio_player_provider.dart';
import '../../resources/song_methods.dart';
import '../../utils/constant.dart';
import '../music/song/list_song_widget.dart';
import '../music/song/music_selection_widget.dart';

class ArtistListSong extends StatelessWidget {
  const ArtistListSong({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ArtistProvider artistProvider = Provider.of<ArtistProvider>(context);

    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
      child: Row(
        children: [
          const RotatedBox(
            quarterTurns: 3,
            child: Text(
              "Top Songs",
              style: kDefaultTitleStyle,
            ),
          ),
          Expanded(
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: artistProvider.songList.length,
                itemBuilder: (context, index) {
                  return new InkWell(
                    onTap: () {
                      context
                          .read<AudioPlayerProvider>()
                          .playSong(artistProvider.artistSongs[index]);
                    },
                    child: MusicSelectionWidget(
                      index: index,
                      song: artistProvider.artistSongs[index],
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
