import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
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
          return const Icon(
            MdiIcons.repeat,
            color: Colors.white,
          );
        case LoopType.loopList:
          return const Icon(
            MdiIcons.repeat,
            color: kPrimaryColor,
          );
        case LoopType.loop1:
          return const Icon(
            MdiIcons.repeatOnce,
            color: kPrimaryColor,
          );
        default:
          return const Icon(
            MdiIcons.repeat,
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
