import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:musix/models/album.dart';
import 'package:musix/resources/playlist_methods.dart';

import '../../../../utils/colors.dart';
import 'add_album_to_favorite_icon_button.dart';

class AlbumControllerWidget extends StatelessWidget {
  const AlbumControllerWidget({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const AddAlbumToFavoriteIconButton(),
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
            IconButton(
              icon: const Icon(
                MdiIcons.shuffle,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            Container(
              height: 35,
              width: 35,
              decoration: const BoxDecoration(
                  color: kPrimaryColor, shape: BoxShape.circle),
              child: const Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 15,
              ),
            ),
          ],
        )
      ],
    );
  }
}
