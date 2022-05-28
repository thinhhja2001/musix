import 'package:flutter/material.dart';
import 'package:musix/models/album.dart';
import 'package:musix/utils/constant.dart';
import 'package:musix/utils/utils.dart';
import 'package:musix/widgets/customs/custom_bottom_navigation_bar.dart';
import 'package:musix/widgets/music/album/album_screen_body.dart';
import 'package:palette_generator/palette_generator.dart';

class AlbumScreen extends StatelessWidget {
  const AlbumScreen({Key? key, required this.album}) : super(key: key);
  final Album album;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomBar(
        items: bottomBarItems,
        onTap: (index) => {},
      ),
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
