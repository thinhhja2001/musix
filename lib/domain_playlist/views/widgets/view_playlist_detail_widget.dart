import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/exporter.dart';
import '../../../global/widgets/widgets.dart';
import '../../../routing/routing_path.dart';
import '../../../theme/theme.dart';
import '../../../utils/utils.dart';
import '../../entities/entities.dart';

class ViewPlaylistDetailWidget extends StatelessWidget {
  const ViewPlaylistDetailWidget({
    super.key,
    required this.playlist,
  });
  final MiniPlaylist playlist;
  @override
  Widget build(BuildContext context) {
    List<String> artists = playlist.artistsNames?.split(',') ?? [];
    bool isMultipleArtist = false;
    if (artists.length != playlist.artistAlias?.length) {
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
      padding: const EdgeInsets.only(left: 12, right: 12, top: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              playlist.thumbnailM ?? AssetPath.placeImage,
              height: 200,
              width: 200,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            playlist.title ?? "",
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
                    text: playlist.artistsNames,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        context.read<ArtistBloc>().add(
                            ArtistGetInfoEvent(playlist.artistAlias!.first));
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
                            context.read<ArtistBloc>().add(ArtistGetInfoEvent(
                                playlist.artistAlias![index]));
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
              List<String> playlists = state.music?.favoritePlaylists ?? [];
              return playlists.contains(playlist.encodeId);
            },
            builder: (context, isFavorite) {
              return DetailChildWidget(
                icon: isFavorite ? Icons.favorite : Icons.favorite_outline,
                data: "Like",
                onPress: () {
                  context.read<UserMusicBloc>().add(CheckPlaylistEvent(
                        id: playlist.encodeId!,
                        title: playlist.title!,
                        artistNames: playlist.artistsNames!,
                        genreNames: playlist.genres,
                        isFavorite: true,
                      ));
                },
              );
            },
          ),
          const SizedBox(
            height: 12,
          ),
          BlocSelector<UserMusicBloc, UserMusicState, bool>(
            selector: (state) {
              List<String> playlists = state.music?.dislikePlaylists ?? [];
              return playlists.contains(playlist.encodeId);
            },
            builder: (context, isDislike) {
              return DetailChildWidget(
                icon: isDislike
                    ? Icons.do_disturb_on
                    : Icons.do_not_disturb_alt_outlined,
                data: "Block",
                onPress: () {
                  context.read<UserMusicBloc>().add(CheckPlaylistEvent(
                        id: playlist.encodeId!,
                        title: playlist.title!,
                        artistNames: playlist.artistsNames!,
                        genreNames: playlist.genres,
                        isFavorite: false,
                      ));
                },
              );
            },
          ),
          const SizedBox(
            height: 12,
          ),
          BlocListener<UserMusicBloc, UserMusicState>(
              child: const SizedBox.shrink(),
              listenWhen: (prev, curr) =>
                  prev.status?[UserMusicStatusKey.playlist.name] !=
                  curr.status?[UserMusicStatusKey.playlist.name],
              listener: (context, state) {
                // Call dialog when user favorite the block music
                if (state.error?.statusCode == 1000) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return PopupWarningWidget(
                          description:
                              'This playlist is in you block list. Do you want to remove it to favorite list?',
                          onTap: () {
                            context
                                .read<UserMusicBloc>()
                                .add(FavoritePlaylistEvent(
                                  id: playlist.encodeId!,
                                  title: playlist.title!,
                                  artistNames: playlist.artistsNames!,
                                  genreNames: playlist.genres,
                                  isRemoveDislike: true,
                                ));
                          },
                        );
                      });
                }
                // Call dialog when user block the favorite music
                else if (state.error?.statusCode == 1001) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return PopupWarningWidget(
                          description:
                              'This playlist is in you favorite list. Do you want to remove it to block list?',
                          onTap: () {
                            context
                                .read<UserMusicBloc>()
                                .add(DislikePlaylistEvent(
                                  id: playlist.encodeId!,
                                  title: playlist.title!,
                                  artistNames: playlist.artistsNames!,
                                  genreNames: playlist.genres,
                                  isRemoveFavorite: true,
                                ));
                          },
                        );
                      });
                }
              }),
        ],
      ),
    );
  }
}
