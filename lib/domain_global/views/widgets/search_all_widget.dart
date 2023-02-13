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
  final bool isRequestIndex;

  const SearchAllWidget({
    Key? key,
    required this.title,
    required this.listDynamic,
    this.isRequestIndex = false,
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
          child: SizedBox(
            height: listDynamic.length * 56,
            child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: listDynamic.length,
                itemBuilder: (context, index) {
                  switch (listDynamic[index].runtimeType.toString()) {
                    case 'Song':
                      return SongCardWidget(
                        isRequestIndex: isRequestIndex,
                        song: listDynamic[index] as Song,
                        index: index + 1,
                        isMini: true,
                      );
                    case 'Artist':
                      return ArtistCardWidget(
                        artist: listDynamic[index] as Artist,
                        index: index + 1,
                        isRequestIndex: isRequestIndex,
                        isMini: true,
                      );
                    case 'Album':
                      return AlbumCardWidget(
                        album: listDynamic[index] as Album,
                        isRequestIndex: isRequestIndex,
                        index: index,
                        isMini: true,
                      );
                    case 'Video':
                      return VideoCardWidget(
                        video: listDynamic[index] as Video,
                        index: index,
                        isRequestIndex: isRequestIndex,
                        isMini: true,
                      );
                    default:
                      return const SizedBox.shrink();
                  }
                }),
          ),
        )
      ],
    );
  }
}
