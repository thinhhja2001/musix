import 'package:flutter/material.dart';
import 'package:musix/providers/artist_provider.dart';
import 'package:provider/provider.dart';

import '../../models/song.dart';
import '../../providers/audio_player_provider.dart';
import '../search/search_component.dart';

class ArtistSongs extends StatelessWidget {
  const ArtistSongs({Key? key, required this.componentList}) : super(key: key);

  final List<Map<String, dynamic>> componentList;

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: componentList.length,
        itemBuilder: (context, index) {
          return new InkWell(
            onTap: () {
              Song song = new Song(
                  id: componentList[index]['id'],
                  name: componentList[index]['name'],
                  audioUrl: componentList[index]['audioUrl'],
                  lyricUrl: componentList[index]['lyricUrl'],
                  artistName: componentList[index]['artistName'],
                  artistLink: componentList[index]['artistLink'],
                  thumbnailUrl: componentList[index]['thumbnailUrl']);
              context.read<AudioPlayerProvider>().playSong(song,context);
            },
            child: SearchComponent(
              artist: componentList[index]['artistName'],
              title: componentList[index]['name'],
              imgLink: componentList[index]['thumbnailUrl'],
            ),
          );
        },
      ),
    );
  }
}
