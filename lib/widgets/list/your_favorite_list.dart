import 'package:flutter/material.dart';
import 'package:musix/widgets/list/favorite_album_list.dart';
import 'package:musix/widgets/list/favorite_song_playlist.dart';

class YourFavoriteListWidget extends StatelessWidget {
  const YourFavoriteListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: const [
            ListFavoriteSongsWidget(),
            ListFavoriteAlbumsWidget()
          ],
        ),
      ),
    );
  }
}
