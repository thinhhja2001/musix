import 'package:flutter/material.dart';
import 'package:musix/models/album.dart';
import 'package:musix/utils/utils.dart';
import 'package:musix/widgets/music/album/album_screen_body.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';

import '../providers/custom_bottom_bar_provider.dart';

class AlbumScreen extends StatelessWidget {
  const AlbumScreen({Key? key, required this.album}) : super(key: key);
  final Album album;

  @override
  Widget build(BuildContext context) {
    CustomBottomBarProvider customBottomBarProvider =
        Provider.of<CustomBottomBarProvider>(context);
    return Scaffold(
      bottomNavigationBar: customBottomBarProvider.customBottomBar,
      body: FutureBuilder<PaletteGenerator>(
        future: updatePaletteGenerator(album.thumbnailUrl),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return AlbumScreenBody(
              album: album,
              snapshot: snapshot.data!,
            );
          }
          return Container();
        },
      ),
    );
  }
}
