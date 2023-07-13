import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../config/exporter.dart';
import '../../../domain_playlist/views/widgets.dart';
import '../../../domain_song/views/widgets.dart';
import '../../../global/widgets/widgets.dart';
import '../../../theme/theme.dart';
import '../../../utils/enum/enum_status.dart';
import '../../entities/entities.dart';

class ArtistInfoScreen extends StatefulWidget {
  const ArtistInfoScreen({Key? key}) : super(key: key);

  @override
  State<ArtistInfoScreen> createState() => _ArtistInfoScreenState();
}

class _ArtistInfoScreenState extends State<ArtistInfoScreen> {
  final controller = FlipCardController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorTheme.background,
      persistentFooterButtons: [CurrentSongPlayerWidget()],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            context.read<ArtistBloc>().add(const ArtistBackInfoEvent());
            Navigator.maybePop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_sharp,
            color: Colors.white,
            size: 20,
          ),
        ),
        actions: [
          BlocSelector<ArtistBloc, ArtistState, Artist?>(
            selector: (state) {
              return state.info;
            },
            builder: (context, artist) {
              if (artist != null) {
                return BlocConsumer<UserMusicBloc, UserMusicState>(
                  listenWhen: (prev, curr) =>
                      prev.status?[UserMusicStatusKey.artist.name] !=
                      curr.status?[UserMusicStatusKey.artist.name],
                  listener: (context, state) {
                    // Call dialog when user favorite the block music
                    if (state.error?.statusCode == 1001) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return PopupWarningWidget(
                              description:
                                  'This artist is in you favorite list. Do you want to remove this artist to block list?',
                              onTap: () {
                                context
                                    .read<UserMusicBloc>()
                                    .add(DislikeArtistEvent(
                                      id: artist.id!,
                                      alias: artist.alias!,
                                      name: artist.name!,
                                      isRemoveFavorite: true,
                                    ));
                              },
                            );
                          });
                    }
                  },
                  builder: (context, state) {
                    List<String> artists = state.music?.dislikeArtists ?? [];
                    bool isDislike = artists.contains(artist.alias);
                    return IconButton(
                      onPressed: () {
                        context.read<UserMusicBloc>().add(CheckArtistEvent(
                              id: artist.id!,
                              alias: artist.alias!,
                              name: artist.name!,
                              isFavorite: false,
                            ));
                      },
                      splashColor: Colors.red.withOpacity(0.2),
                      tooltip: 'Dislike',
                      icon: Icon(
                        isDislike
                            ? Icons.do_disturb_on
                            : Icons.do_not_disturb_alt_outlined,
                        color: Colors.red.withOpacity(0.8),
                        size: 24,
                      ),
                    );
                  },
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.do_not_disturb_alt_outlined,
                    color: Colors.red.withOpacity(0.8),
                    size: 24,
                  ),
                );
              }
            },
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          BlocBuilder<ArtistBloc, ArtistState>(
            builder: (context, state) {
              if (state.status?[ArtistStatusKey.info.key] == Status.loading) {
                return const Center(
                    child: SpinKitPulse(
                  color: ColorTheme.primary,
                  size: 100,
                ));
              } else {
                final info = state.info;
                if (info == null) {
                  return const SizedBox.shrink();
                } else {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        FlipCard(
                          rotateSide: RotateSide.left,
                          onTapFlipping: true,
                          axis: FlipAxis.vertical,
                          controller: controller,
                          frontWidget: Container(
                            width: size.width,
                            height: size.height * 0.5,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.white.withOpacity(0.01),
                                  Colors.white.withOpacity(0.5),
                                ],
                              ),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(32),
                                bottomRight: Radius.circular(32),
                              ),
                              image: DecorationImage(
                                image: NetworkImage(
                                  info.thumbnailM!,
                                ),
                                fit: BoxFit.fitHeight,
                                opacity: 0.8,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 28,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  info.name!,
                                  style: TextStyleTheme.ts28.copyWith(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                if (info.birthday != null)
                                  Text(
                                    info.birthday!,
                                    style: TextStyleTheme.ts14.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: ColorTheme.primaryLighten,
                                    ),
                                  ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text.rich(
                                  TextSpan(children: <InlineSpan>[
                                    TextSpan(
                                      text: info.sortBiography,
                                    ),
                                  ]),
                                  style: TextStyleTheme.ts14.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      context
                                          .read<UserMusicBloc>()
                                          .add(CheckArtistEvent(
                                            id: info.id!,
                                            name: info.name!,
                                            alias: info.alias!,
                                            isFavorite: true,
                                          ));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: ColorTheme.primary,
                                    ),
                                    child: BlocConsumer<UserMusicBloc,
                                        UserMusicState>(
                                      listenWhen: (prev, curr) =>
                                          prev.status?[
                                              UserMusicStatusKey.artist.name] !=
                                          curr.status?[
                                              UserMusicStatusKey.artist.name],
                                      listener: (context, state) {
                                        if (state.error?.statusCode == 1000) {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return PopupWarningWidget(
                                                  description:
                                                      'This artist is in you block list. Do you want to remove this artist to favorite list?',
                                                  onTap: () {
                                                    context
                                                        .read<UserMusicBloc>()
                                                        .add(
                                                            FavoriteArtistEvent(
                                                          id: info.id!,
                                                          name: info.name!,
                                                          alias: info.alias!,
                                                          isRemoveDislike: true,
                                                        ));
                                                  },
                                                );
                                              });
                                        }
                                      },
                                      builder: (context, state) {
                                        List<String> artists =
                                            state.music?.favoriteArtists ?? [];
                                        bool isFollow =
                                            artists.contains(info.alias);
                                        return Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              isFollow ? 'Followed' : 'Follow',
                                              style:
                                                  TextStyleTheme.ts16.copyWith(
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 6,
                                            ),
                                            Icon(
                                              isFollow
                                                  ? Icons.check
                                                  : Icons.add,
                                              size: 16,
                                              color: Colors.white,
                                            )
                                          ],
                                        );
                                      },
                                    )),
                              ],
                            ),
                          ),
                          backWidget: Container(
                            width: size.width,
                            height: size.height * 0.5,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.white.withOpacity(0.01),
                                  Colors.white.withOpacity(0.5),
                                ],
                              ),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(32),
                                bottomRight: Radius.circular(32),
                              ),
                              image: DecorationImage(
                                image: NetworkImage(
                                  info.thumbnailM!,
                                ),
                                fit: BoxFit.fitHeight,
                                opacity: 0.8,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 28,
                            ),
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.only(
                                top: 64,
                              ),
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    info.biography
                                            ?.replaceAll('<br>', '- ')
                                            .replaceAll('- ', '') ??
                                        '',
                                    style: TextStyleTheme.ts14.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        ...List.generate(info.sectionPlaylist?.length ?? 0,
                            (index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: PlaylistListWidget(
                              playlistArrange: PlaylistArrange.carousel,
                              sectionPlaylist: info.sectionPlaylist![index],
                            ),
                          );
                        }),
                        const SizedBox(
                          height: 12,
                        ),
                        SongListWidget(
                          sectionSong: info.songs!,
                          isScrollable: false,
                          isShowIndex: true,
                          songArrange: SongArrange.info,
                        ),
                      ],
                    ),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
