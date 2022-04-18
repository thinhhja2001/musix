import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:musix/providers/audio_player_provider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import '../utils/colors.dart';
import '../utils/constant.dart';

class CurrentMusicPlayer extends StatelessWidget {
  CurrentMusicPlayer({
    Key? key,
    required this.song,
    required this.singer,
    required this.image,
    required this.borderColor,
    required this.songUrl,
  }) : super(key: key);
  final String song;
  final String singer;
  final String image;
  final Color borderColor;
  final String songUrl;

  @override
  Widget build(BuildContext context) {
    final audioPlayerProvider = Provider.of<AudioPlayerProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(color: borderColor, blurRadius: 4),
                ]),
            child: CircleAvatar(
                backgroundImage: NetworkImage(image),
                radius: 25,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(color: borderColor, blurRadius: 4),
                      ]),
                  child: const CircleAvatar(
                    radius: 10,
                    backgroundColor: kBackgroundColorDarker,
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  song,
                  style: kDefaultTextStyle.copyWith(
                      fontSize: 16, fontWeight: FontWeight.w400),
                ),
                Text(
                  singer,
                  style: kDefaultTextStyle.copyWith(
                      color: kPrimaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                Container(
                  transform: Matrix4.translationValues(-20, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SliderTheme(
                        data: const SliderThemeData(
                            trackHeight: 2,
                            thumbColor: kPrimaryColor,
                            thumbShape:
                                RoundSliderThumbShape(enabledThumbRadius: 0)),
                        child: Slider(
                            activeColor: kPrimaryColor,
                            min: 0,
                            max: audioPlayerProvider.duration.inSeconds
                                .toDouble(),
                            value: audioPlayerProvider.position.inSeconds
                                .toDouble(),
                            onChanged: (value) async {
                              final position = Duration(seconds: value.toInt());
                              audioPlayerProvider.seekToNewPosition(position);
                            }),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Icon(
                            Icons.shuffle,
                            color: Colors.white,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: InkWell(
                              onTap: () async {
                                if (audioPlayerProvider.isPlaying) {
                                  audioPlayerProvider.pauseAudio();
                                } else {
                                  audioPlayerProvider.playAudio();
                                }
                                audioPlayerProvider.changePlayState();
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: kPrimaryColor,
                                    shape: BoxShape.circle),
                                child: Icon(
                                  audioPlayerProvider.isPlaying == false
                                      ? Icons.play_arrow
                                      : Icons.pause,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
