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
    return StreamBuilder<bool>(
        stream: audioPlayerProvider.audioPlayer.playingStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final isPlaying = snapshot.data!;
            return InkWell(
              onTap: () async {
                if (isPlaying) {
                  audioPlayerProvider.pauseSong();
                } else {
                  audioPlayerProvider.resume();
                }
              },
              child: Container(
                height: buttonSize,
                width: buttonSize,
                decoration: const BoxDecoration(
                    color: kPrimaryColor, shape: BoxShape.circle),
                child: Icon(
                  !isPlaying ? Icons.play_arrow : Icons.pause,
                  color: Colors.white,
                  size: iconSize,
                ),
              ),
            );
          }

          return InkWell(
            onTap: () async {},
            child: Container(
              height: buttonSize,
              width: buttonSize,
              decoration: const BoxDecoration(
                  color: kPrimaryColor, shape: BoxShape.circle),
              child: Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: iconSize,
              ),
            ),
          );
        });
  }
}
