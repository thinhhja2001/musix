import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:musix/models/song.dart';
import 'package:musix/providers/audio_player_provider.dart';
import 'package:provider/provider.dart';
import 'package:text_scroll/text_scroll.dart';
import 'package:video_player/video_player.dart';

import '../utils/colors.dart';
import '../utils/constant.dart';

class MusicSelectionWidget extends StatelessWidget {
  const MusicSelectionWidget({
    Key? key,
    required this.index,
    required this.song,
  }) : super(key: key);
  final int index;
  final Song song;
  @override
  Widget build(BuildContext context) {
    final AudioPlayerProvider audioPlayerProvider =
        Provider.of<AudioPlayerProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: InkWell(
        onTap: () => audioPlayerProvider.playSong(song),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "#${index + 1}",
              style: kDefaultTitleStyle.copyWith(fontSize: 16),
            ),
            horizontalSpaceSmall,
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  image: DecorationImage(
                      image: NetworkImage(song.thumbnailUrl),
                      fit: BoxFit.cover)),
            ),
            horizontalSpaceSmall,
            Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      song.name,
                      overflow: TextOverflow.ellipsis,
                      style: kDefaultTitleStyle.copyWith(
                          fontSize: 16,
                          color: song.id == audioPlayerProvider.currentSong.id
                              ? kPrimaryColor
                              : Colors.white),
                    ),
                    Text(
                      song.artistName,
                      style: kDefaultTitleStyle.copyWith(
                          fontSize: 14, color: Colors.grey),
                    )
                  ],
                )),
            Expanded(
                child: IconButton(
              onPressed: () => {},
              icon: const Icon(
                Icons.arrow_downward,
                color: kPrimaryColor,
              ),
            ))
          ],
        ),
      ),
    );
  }
}
