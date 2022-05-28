import 'package:flutter/material.dart';

import '../album/all_album_of_current_user.dart';

class AddSongToPlaylistIconButton extends StatelessWidget {
  const AddSongToPlaylistIconButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => const AllAlbumOfCurrentUser()),
            },
        icon: const Icon(
          Icons.playlist_add,
          color: Colors.white,
        ));
  }
}
