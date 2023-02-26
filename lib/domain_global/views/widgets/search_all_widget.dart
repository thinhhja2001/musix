import 'package:flutter/material.dart';
import '../../../domain_artist/entities/artist/mini_artist.dart';
import '../../../domain_artist/entities/artist/mini_artist.dart';

import '../../../domain_artist/views/widgets.dart';
import '../../../domain_song/entities/entities.dart';
import '../../../domain_song/models/models.dart';
import '../../../domain_song/views/widgets.dart';
import '../../../domain_video/models/video_detail_model.dart';
import '../../../domain_playlist/entities/entities.dart';
import '../../../domain_playlist/views/widgets.dart';
import '../../../global/widgets/widgets.dart';

class SearchAllWidget extends StatelessWidget {
  final String title;
  final List<dynamic> listDynamic;
  final bool isShowIndex;
  final bool isScrollable;

  const SearchAllWidget({
    Key? key,
    required this.title,
    required this.listDynamic,
    this.isShowIndex = false,
    this.isScrollable = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RotatedTextWidget(text: title),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: isScrollable
                ? const BouncingScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...List.generate(
                  listDynamic.length,
                  (index) {
                    switch (listDynamic[index].runtimeType.toString()) {
                      case 'SongInfo':
                        return SongCardWidget(
                          song: listDynamic[index] as SongInfo,
                          isShowIndex: isShowIndex,
                          isShowType: true,
                          index: index + 1,
                          onPress: () {},
                          type: SongType.cardInfo,
                        );
                      case 'MiniArtist':
                        return ArtistCardWidget(
                          artist: listDynamic[index] as MiniArtist,
                          isShowIndex: isShowIndex,
                          isShowType: true,
                          index: index + 1,
                          onPress: () {},
                          type: ArtistType.cardInfo,
                        );
                      case 'MiniPlaylist':
                        return PlaylistCardWidget(
                          playlist: listDynamic[index] as MiniPlaylist,
                          isShowIndex: isShowIndex,
                          isShowType: true,
                          index: index + 1,
                          onPress: () {},
                          type: PlaylistType.cardInfo,
                        );

                      default:
                        return const SizedBox.shrink();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
