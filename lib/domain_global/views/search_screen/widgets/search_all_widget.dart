import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/exporter.dart';
import '../../../../domain_song/entities/entities.dart';
import '../../../../domain_song/views/widgets.dart';
import '../../../../global/widgets/widgets.dart';
import '../../../../routing/routing_path.dart';
import '../../../../utils/utils.dart';
import '../../../entities/entities.dart';
import '../../../utils/utils.dart';

class SearchAllWidget extends StatelessWidget {
  final SectionAll all;
  final bool isShowIndex;
  final bool isScrollable;

  const SearchAllWidget({
    Key? key,
    required this.all,
    this.isShowIndex = false,
    this.isScrollable = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<SongInfo> songs = [];
    all.items?.forEach((element) {
      element.type == MusicType.song
          ? songs.add(convertSongInfoFromAllSearching(element))
          : null;
    });
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (all.title != null) ...[
          RotatedTextWidget(text: all.title!),
          const SizedBox(
            width: 8,
          ),
        ],
        if (all.items == null || all.items?.isEmpty == true)
          ...[]
        else
          Expanded(
            child: SingleChildScrollView(
              physics: isScrollable
                  ? const BouncingScrollPhysics()
                  : const NeverScrollableScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...List.generate(
                    all.items!.length,
                    (index) {
                      final item = all.items![index];
                      if (item.type == MusicType.song) {
                        return SongCardInfoWidget(
                          song: convertSongInfoFromAllSearching(item),
                          onPress: () async {
                            context
                                .read<SongBloc>()
                                .add(SongSetListSongInfoEvent(
                                  songs,
                                ));
                            context.read<SongBloc>().add(
                                SongStartPlayingSectionEvent(songs.indexOf(
                                    convertSongInfoFromAllSearching(item))));
                          },
                          index: index,
                          isShowType: true,
                        );
                      }
                      return CustomCardInfoWidget(
                        index: index,
                        image: item.thumbnail,
                        title: item.title!,
                        subTitle: item.artistsName,
                        type: convertMusicType[item.type],
                        isShowAdditionButton: false,
                        onCardPress: () {
                          if (item.type == MusicType.playlist) {
                            context
                                .read<PlaylistBloc>()
                                .add(PlaylistGetInfoEvent(item.id!));
                            Navigator.pushNamed(
                              context,
                              RoutingPath.playlistInfo,
                            );
                          } else if (item.type == MusicType.artist) {
                            context
                                .read<ArtistBloc>()
                                .add(ArtistGetInfoEvent(item.alias!));
                            Navigator.pushNamed(
                              context,
                              RoutingPath.artistInfo,
                            );
                          }
                        },
                      );
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
