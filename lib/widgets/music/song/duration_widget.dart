import 'package:flutter/material.dart';
import 'package:musix/providers/audio_player_provider.dart';
import 'package:musix/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../../utils/constant.dart';

class DurationWidget extends StatelessWidget {
  const DurationWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final audioPlayerProvider = Provider.of<AudioPlayerProvider>(context);

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.055),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            formatDuration(audioPlayerProvider.position.inSeconds),
            style: kDefaultTextStyle,
          ),
          Text(
            formatDuration(audioPlayerProvider.duration.inSeconds),
            style: kDefaultTextStyle,
          )
        ],
      ),
    );
  }
}
