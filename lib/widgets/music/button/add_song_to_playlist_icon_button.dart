import 'package:flutter/material.dart';
import 'package:musix/models/song.dart';

import '../album/all_album_of_current_user.dart';

class AddSongToPlaylistIconButton extends StatelessWidget {
  const AddSongToPlaylistIconButton({
    Key? key,
    required this.song,
  }) : super(key: key);
  final Song song;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => AllAlbumOfCurrentUser(
                        song: song,
                      )),
            },
        icon: const Icon(
          Icons.playlist_add,
          color: Colors.white,
        ));
  }
}
