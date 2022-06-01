import 'package:flutter/material.dart';
import 'package:musix/models/album.dart';
import 'package:musix/providers/custom_bottom_bar_provider.dart';
import 'package:musix/resources/playlist_methods.dart';
import 'package:musix/utils/colors.dart';
import 'package:musix/utils/utils.dart';
import 'package:musix/widgets/music/album/album_screen_body.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';

class AlbumScreenFromAlbumKey extends StatelessWidget {
  const AlbumScreenFromAlbumKey({Key? key, required this.albumKey})
      : super(key: key);
  final String albumKey;
  @override
  Widget build(BuildContext context) {
    CustomBottomBarProvider customBottomBarProvider =
        Provider.of<CustomBottomBarProvider>(context);
    return Scaffold(
      bottomNavigationBar: customBottomBarProvider.customBottomBar,
      body: FutureBuilder<Album>(
        future: PlaylistMethods.getAlbumDataByKey(albumKey),
        builder: (context, albumData) {
          if (albumData.hasData) {
            return FutureBuilder<PaletteGenerator>(
              future: updatePaletteGenerator(albumData.data!.thumbnailUrl),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return AlbumScreenBody(
                    album: albumData.data!,
                    snapshot: snapshot.data!,
                  );
                }
                return Container();
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
