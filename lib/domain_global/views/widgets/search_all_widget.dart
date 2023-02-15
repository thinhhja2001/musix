import 'package:flutter/material.dart';
import 'package:musix/domain_album/models/models.dart';
import 'package:musix/domain_album/views/widgets.dart';
import 'package:musix/domain_artist/models/artist.dart';
import 'package:musix/domain_artist/views/widgets.dart';

import '../../../domain_music/models/models.dart';
import '../../../domain_music/views/widgets.dart';
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
                          song: listDynamic[index] as Song,
                          index: index + 1,
                          isHasType: true,
                          onPress: () {},
                        );
                      case 'Artist':
                        return ArtistCardWidget(
                          artist: listDynamic[index] as Artist,
                          index: index + 1,
                          isRequestIndex: isShowIndex,
                          isHasType: true,
                          onPress: () {},
                        );
                      case 'Album':
                        return AlbumCardWidget(
                          album: listDynamic[index] as Album,
                          isRequestIndex: isShowIndex,
                          index: index,
                          isHasType: true,
                          onPress: () {},
                        );
                      case 'Video':
                        return VideoCardWidget(
                          video: listDynamic[index] as Video,
                          index: index,
                          isRequestIndex: isShowIndex,
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
