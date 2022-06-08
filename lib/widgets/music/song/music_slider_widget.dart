import 'package:flutter/material.dart';
import 'package:musix/common.dart';
import 'package:musix/providers/audio_player_provider.dart';
import 'package:musix/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

import '../../../utils/colors.dart';

class MusicSliderWidget extends StatelessWidget {
  const MusicSliderWidget({
    Key? key,
    required this.isSlidable,
  }) : super(key: key);
  final bool isSlidable;

  @override
  Widget build(BuildContext context) {
    final audioPlayerProvider = Provider.of<AudioPlayerProvider>(context);

    void _onDurationChanged(double value) {
      final position = Duration(seconds: value.toInt());
      audioPlayerProvider.seekToNewPosition(position);
    }

    return SliderTheme(
      data: SliderThemeData(
          trackHeight: 2,
          thumbColor: kPrimaryColor,
          thumbShape:
              RoundSliderThumbShape(enabledThumbRadius: isSlidable ? 5 : 0)),
      child: StreamBuilder<PositionData>(
          stream: positionDataStream(audioPlayerProvider),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final positionData = snapshot.data!;
              return Slider(
                  //Because some song will have its actual duration greater than its duration.
                  //So that we will set the max value of the Slider widget to be its position + 5 to avoid assertion
                  thumbColor: kPrimaryColor,
                  activeColor: kPrimaryColor,
                  min: 0,
                  // max: audioPlayerProvider.duration.inSeconds.toDouble() + 5,
                  max: positionData.duration.inSeconds.toDouble() + 5,
                  value: positionData.position.inSeconds.toDouble(),
                  onChanged: (value) async {
                    isSlidable ? _onDurationChanged(value) : null;
                  });
            }
            return Slider(
                //Because some song will have its actual duration greater than its duration.
                //So that we will set the max value of the Slider widget to be its position + 5 to avoid assertion
                thumbColor: kPrimaryColor,
                activeColor: kPrimaryColor,
                min: 0,
                // max: audioPlayerProvider.duration.inSeconds.toDouble() + 5,
                max: 0.0,
                value: 0.0,
                onChanged: (value) async {
                  isSlidable ? _onDurationChanged(value) : null;
                });
          }),
    );
  }
}
