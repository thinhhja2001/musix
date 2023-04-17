import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain_user/views/own_playlists_screen/widgets.dart';
import '../../../theme/color.dart';

import '../../../config/exporter.dart';
import '../../../global/widgets/widgets.dart';
import '../../../routing/routing_path.dart';
import '../../../theme/text_style.dart';
import '../../../utils/utils.dart';
import '../../entities/entities.dart';

class ViewSongDetailWidget extends StatelessWidget {
  const ViewSongDetailWidget({
    super.key,
    required this.song,
  });

  final SongInfo song;

  @override
  Widget build(BuildContext context) {
    List<String> artists = song.artistsNames?.split(',') ?? [];
    bool isMultipleArtist = false;
    if (artists.length != song.artistsId?.length) {
      isMultipleArtist = true;
    }
    return Container(
      decoration: const BoxDecoration(
        color: ColorTheme.backgroundDarker,
        borderRadius: BorderRadius.all(
          Radius.circular(
            20,
          ),
        ),
      ),
      padding: const EdgeInsets.only(left: 12, right: 12, top: 20, bottom: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              song.thumbnailM ?? AssetPath.placeImage,
              height: 200,
              width: 200,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            song.title ?? "",
            style: TextStyleTheme.ts20.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Text.rich(
            TextSpan(
              children: <InlineSpan>[
                if (artists.isEmpty || isMultipleArtist) ...[
                  TextSpan(
                    text: song.artistsNames,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        context
                            .read<ArtistBloc>()
                            .add(ArtistGetInfoEvent(song.artistsId!.first));
                        Navigator.of(context).pushNamed(
                          RoutingPath.artistInfo,
                        );
                      },
                  )
                ] else
                  ...List.generate(
                    artists.length,
                    (index) => TextSpan(
                        text: artists[index],
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.read<ArtistBloc>().add(
                                ArtistGetInfoEvent(song.artistsId![index]));
                            Navigator.of(context).pushNamed(
                              RoutingPath.artistInfo,
                            );
                          },
                        children: index < artists.length - 1
                            ? const [TextSpan(text: ', ')]
                            : null),
                  ),
              ],
            ),
            style: TextStyleTheme.ts15.copyWith(
              color: Colors.grey,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          BlocSelector<UserMusicBloc, UserMusicState, bool>(
            selector: (state) {
              List<String> songs = state.music?.favoriteSongs ?? [];
              return songs.contains(song.encodeId);
            },
            builder: (context, isFavorite) {
              return DetailChildWidget(
                icon: isFavorite ? Icons.favorite : Icons.favorite_outline,
                data: "Like",
                onPress: () {
                  context.read<UserMusicBloc>().add(FavoriteSongEvent(
                        id: song.encodeId!,
                        title: song.title!,
                        artistNames: song.artistsNames!,
                        genreNames: song.genreNames,
                      ));
                },
              );
            },
          ),
          const SizedBox(
            height: 12,
          ),
          DetailChildWidget(
            icon: Icons.playlist_add,
            data: "Add to playlist",
            onPress: () {
              showDialog(
                  context: context,
                  builder: (context) => SaveSongOwnPlaylistWidget(
                        song: song,
                      ));
            },
          ),
          const SizedBox(
            height: 12,
          ),
          BlocSelector<UserMusicBloc, UserMusicState, bool>(
            selector: (state) {
              List<String> songs = state.music?.dislikeSongs ?? [];
              return songs.contains(song.encodeId);
            },
            builder: (context, isDislike) {
              return DetailChildWidget(
                icon: isDislike
                    ? Icons.do_disturb_on
                    : Icons.do_not_disturb_alt_outlined,
                data: "Block",
                onPress: () {
                  context.read<UserMusicBloc>().add(DislikeSongEvent(
                        id: song.encodeId!,
                        title: song.title!,
                        artistNames: song.artistsNames!,
                        genreNames: song.genreNames,
                      ));
                },
              );
            },
          ),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}
