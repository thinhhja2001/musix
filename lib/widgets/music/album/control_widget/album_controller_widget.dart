import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:musix/models/album.dart';
import 'package:musix/providers/audio_player_provider.dart';
import 'package:musix/widgets/music/album/control_widget/play_album_icon_button.dart';
import 'package:musix/widgets/music/album/control_widget/play_shuffle_icon_button.dart';
import 'package:provider/provider.dart';

import '../../../../utils/colors.dart';
import 'add_album_to_favorite_icon_button.dart';

class AlbumControllerWidget extends StatelessWidget {
  const AlbumControllerWidget({
    Key? key,
    required this.album,
  }) : super(key: key);
  final Album album;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            AddAlbumToFavoriteIconButton(album: album),
            IconButton(
              icon: const Icon(
                MdiIcons.trayArrowDown,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ],
        ),
        Row(
          children: [
            PlayShuffleIconButton(album: album),
            PlayAlbumIconButton(album: album),
          ],
        )
      ],
    );
  }
}
