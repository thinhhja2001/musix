import 'package:flutter/material.dart';
import 'package:musix/common.dart';
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
      child: StreamBuilder<PositionData>(
          stream: positionDataStream(audioPlayerProvider),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final positionData = snapshot.data!;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formatDuration(positionData.position.inSeconds),
                    style: kDefaultTextStyle,
                  ),
                  Text(
                    formatDuration(positionData.duration.inSeconds),
                    style: kDefaultTextStyle,
                  )
                ],
              );
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatDuration(0),
                  style: kDefaultTextStyle,
                ),
                Text(
                  formatDuration(0),
                  style: kDefaultTextStyle,
                )
              ],
            );
          }),
    );
  }
}
