import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:musix/providers/audio_player_provider.dart';
import 'package:musix/widgets/music/button/control_widget/play_music_button.dart';
import 'package:musix/widgets/music/button/control_widget/repeat_icon_button.dart';
import 'package:provider/provider.dart';

import '../button/control_widget/shuffle_icon_button.dart';

class MusicControllerWidget extends StatelessWidget {
  const MusicControllerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AudioPlayerProvider audioPlayerProvider =
        Provider.of<AudioPlayerProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const ShuffleIconButton(),
        IconButton(
          onPressed: () async {
            audioPlayerProvider.playBackward(context);
          },
          icon: const Icon(MdiIcons.skipPreviousOutline),
          color: Colors.white,
        ),
        const PlayMusicButton(
          buttonSize: 75,
          iconSize: 40,
        ),
        IconButton(
          onPressed: () async {
            audioPlayerProvider.playForward(context);
          },
          icon: const Icon(MdiIcons.skipNextOutline),
          color: Colors.white,
        ),
        const RepeatIconButton(),
      ],
    );
  }
}
