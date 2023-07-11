import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../config/exporter.dart';
import '../../../domain_playlist/views/widgets.dart';
import '../../../domain_song/views/widgets.dart';
import '../../../theme/theme.dart';
import '../../../utils/enum/enum_status.dart';

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
                                          .add(FavoriteArtistEvent(
                                            id: info.id!,
                                            name: info.name!,
                                            alias: info.alias!,
                                          ));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: ColorTheme.primary,
                                    ),
                                    child: BlocSelector<UserMusicBloc,
                                        UserMusicState, bool>(
                                      selector: (userMusicState) {
                                        List<String> artists = userMusicState
                                                .music?.favoriteArtists ??
                                            [];
                                        return artists.contains(info.alias);
                                      },
                                      builder: (context, isFollow) {
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
