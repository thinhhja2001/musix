import 'package:flutter/material.dart';
import 'package:musix/providers/audio_player_provider.dart';
import 'package:provider/provider.dart';

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
      child: Slider(
          thumbColor: kPrimaryColor,
          activeColor: kPrimaryColor,
          min: 0,
          max: audioPlayerProvider.duration.inSeconds.toDouble(),
          value: audioPlayerProvider.position.inSeconds.toDouble(),
          onChanged: (value) async {
            isSlidable ? _onDurationChanged(value) : null;
          }),
    );
  }
}
