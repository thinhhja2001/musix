import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/audio_player_provider.dart';
import '../../../../utils/colors.dart';

class PlayMusicButton extends StatelessWidget {
  const PlayMusicButton({
    Key? key,
    required this.buttonSize,
    required this.iconSize,
  }) : super(key: key);
  final double buttonSize;
  final double iconSize;
  @override
  Widget build(BuildContext context) {
    final audioPlayerProvider = Provider.of<AudioPlayerProvider>(context);
    return InkWell(
      onTap: () async {
        if (audioPlayerProvider.isPlaying) {
          audioPlayerProvider.pauseSong();
        } else {
          audioPlayerProvider.playSong(
              audioPlayerProvider.currentSong, context);
        }
        audioPlayerProvider.changePlayState();
      },
      child: Container(
        height: buttonSize,
        width: buttonSize,
        decoration:
            const BoxDecoration(color: kPrimaryColor, shape: BoxShape.circle),
        child: Icon(
          audioPlayerProvider.isPlaying == false
              ? Icons.play_arrow
              : Icons.pause,
          color: Colors.white,
          size: iconSize,
        ),
      ),
    );
  }
}