import 'package:audio_manager/audio_manager.dart';
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
        !audioPlayerProvider.isPlaying
            ? audioPlayerProvider.playSong(audioPlayerProvider.currentSong)
            : audioPlayerProvider.pauseSong();
        audioPlayerProvider.changeIsPlayingState();
      },
      child: Container(
        height: buttonSize,
        width: buttonSize,
        decoration:
            const BoxDecoration(color: kPrimaryColor, shape: BoxShape.circle),
        child: Icon(
          !audioPlayerProvider.isPlaying ? Icons.play_arrow : Icons.pause,
          color: Colors.white,
          size: iconSize,
        ),
      ),
    );
  }
}
