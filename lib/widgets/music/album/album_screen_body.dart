import 'package:flutter/material.dart';
import 'package:musix/models/album.dart';
import 'package:musix/models/song.dart';
import 'package:musix/resources/song_methods.dart';
import 'package:musix/widgets/music/album/control_widget/album_controller_widget.dart';
import 'package:musix/widgets/music/song/music_selection_widget.dart';
import 'package:palette_generator/palette_generator.dart';

import '../../../utils/constant.dart';
import '../../../utils/utils.dart';

class AlbumScreenBody extends StatelessWidget {
  const AlbumScreenBody({
    Key? key,
    required this.snapshot,
    required this.album,
  }) : super(key: key);
  final Album album;
  final PaletteGenerator snapshot;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [snapshot.dominantColor!.color, Colors.black],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05,
          ),
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  goBackButton(),
                  verticalSpaceSmall,
                  Text(
                    album.title,
                    style: kDefaultTextStyle.copyWith(
                        fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  verticalSpaceSmall,
                  _AlbumThumbnail(
                    thumbnailUrl: album.thumbnailUrl,
                  ),
                  verticalSpaceSmall,
                  AlbumControllerWidget(album: album),
                  verticalSpaceSmall,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          "All song",
                          style: kDefaultTitleStyle,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: List.generate(
                              album.songs.length,
                              (index) => FutureBuilder(
                                  future: SongMethods.getSongDataByKey(
                                      album.songs[index]),
                                  builder:
                                      (context, AsyncSnapshot<Song> snapshot) {
                                    if (snapshot.hasData) {
                                      return MusicSelectionWidget(
                                          index: index, song: snapshot.data!);
                                    }
                                    return MusicSelectionWidget(
                                        index: index, song: songWithNoData);
                                  })),
                        ),
                      )
                    ],
                  )
                ]),
          ),
        ),
      ),
    );
  }
}

class _AlbumThumbnail extends StatelessWidget {
  const _AlbumThumbnail({
    Key? key,
    required this.thumbnailUrl,
  }) : super(key: key);
  final String thumbnailUrl;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.height * 0.3,
        decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage(thumbnailUrl))),
      ),
    );
  }
}
