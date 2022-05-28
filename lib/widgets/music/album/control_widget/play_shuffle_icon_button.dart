import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:musix/models/album.dart';
import 'package:musix/providers/audio_player_provider.dart';
import 'package:musix/utils/colors.dart';
import 'package:provider/provider.dart';

class PlayShuffleIconButton extends StatelessWidget {
  const PlayShuffleIconButton({
    Key? key,
    required this.album,
  }) : super(key: key);
  final Album album;
  @override
  Widget build(BuildContext context) {
    final AudioPlayerProvider audioPlayerProvider =
        Provider.of<AudioPlayerProvider>(context);
    return IconButton(
      icon: Icon(
        MdiIcons.shuffle,
        color: audioPlayerProvider.isPlayShuffle ? kPrimaryColor : Colors.white,
      ),
      onPressed: () => audioPlayerProvider.toggleIsPlayShuffle(),
    );
  }
}
