import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:musix/providers/audio_player_provider.dart';
import 'package:musix/utils/colors.dart';
import 'package:provider/provider.dart';

class ShuffleIconButton extends StatelessWidget {
  const ShuffleIconButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final audioPlayerProvider = Provider.of<AudioPlayerProvider>(context);
    return IconButton(
      onPressed: audioPlayerProvider.toggleIsPlayShuffle,
      icon: const Icon(MdiIcons.shuffle),
      color: audioPlayerProvider.isPlayShuffle ? kPrimaryColor : Colors.white,
    );
  }
}
