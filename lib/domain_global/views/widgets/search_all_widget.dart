import 'package:flutter/material.dart';
import '../../../domain_album/entities/entities.dart';
import '../../../domain_artist/entities/artist/mini_artist.dart';

import '../../../domain_album/views/widgets.dart';
import '../../../domain_artist/views/widgets.dart';
import '../../../domain_song/entities/entities.dart';
import '../../../domain_song/models/models.dart';
import '../../../domain_song/views/widgets.dart';
import '../../../domain_video/models/video_detail_model.dart';
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
                      case 'Song':
                        return SongCardWidget(
                          isRequestIndex: isShowIndex,
                          song: listDynamic[index] as SongInfo,
                          index: index + 1,
                          isHasType: true,
                          onPress: () {},
                        );
                      case 'Artist':
                        return ArtistCardWidget(
                          artist: listDynamic[index] as MiniArtist,
                          index: index + 1,
                          isRequestIndex: isShowIndex,
                          isHasType: true,
                          onPress: () {},
                        );
                      case 'Album':
                        return AlbumCardWidget(
                          playlist: listDynamic[index] as MiniPlaylist,
                          isRequestIndex: isShowIndex,
                          index: index,
                          isHasType: true,
                          onPress: () {},
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
