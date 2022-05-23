import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:musix/providers/audio_player_provider.dart';
import 'package:musix/utils/colors.dart';
import 'package:musix/utils/enums.dart';
import 'package:provider/provider.dart';

class RepeatIconButton extends StatelessWidget {
  const RepeatIconButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final audioPlayerProvider = Provider.of<AudioPlayerProvider>(context);

    Widget _getSvgImage() {
      switch (audioPlayerProvider.loopType) {
        case LoopType.noLoop:
          return SvgPicture.asset(
            'assets/images/repeat.svg',
            width: 16,
            height: 16,
            color: Colors.white,
          );
        case LoopType.loopList:
          return SvgPicture.asset(
            'assets/images/repeat.svg',
            width: 16,
            height: 16,
            color: kPrimaryColor,
          );
        case LoopType.loop1:
          return SvgPicture.asset(
            'assets/images/repeat-1.svg',
            width: 16,
            height: 16,
            color: kPrimaryColor,
          );
        default:
          return SvgPicture.asset(
            'assets/images/repeat.svg',
            width: 16,
            height: 16,
            color: Colors.white,
          );
      }
    }

    return IconButton(
      onPressed: () => audioPlayerProvider.changeLoopStyle(),
      icon: _getSvgImage(),
      color: Colors.white,
    );
  }
}
