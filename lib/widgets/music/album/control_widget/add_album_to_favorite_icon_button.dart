import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:musix/models/album.dart';
import 'package:musix/providers/album_provider.dart';
import 'package:musix/resources/playlist_methods.dart';
import 'package:musix/utils/colors.dart';
import 'package:provider/provider.dart';

class AddAlbumToFavoriteIconButton extends StatelessWidget {
  const AddAlbumToFavoriteIconButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AlbumProvider albumProvider = Provider.of<AlbumProvider>(context);

    return FutureBuilder<List>(
        future: PlaylistMethods.getAllFavoriteAlbumOfCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return IconButton(
              onPressed: () => {
                PlaylistMethods.onFavoriteAlbumClickHandler(
                    albumProvider.currentAlbum)
              },
              icon: Icon(
                snapshot.data!.contains(albumProvider.currentAlbum.id)
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: snapshot.data!.contains(albumProvider.currentAlbum.id)
                    ? kPrimaryColor
                    : Colors.white,
              ),
            );
          }
          return Container();
        });
  }
}
