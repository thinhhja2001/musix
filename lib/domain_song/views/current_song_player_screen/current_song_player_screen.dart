import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/config/exporter.dart';
import 'package:musix/domain_user/views/own_playlists_screen/widgets.dart';
import 'package:palette_generator/palette_generator.dart';

import '../../../global/widgets/widgets.dart';
import '../../../routing/routing_path.dart';
import '../../../theme/color.dart';
import '../../../theme/text_style.dart';
import '../../../utils/functions/function_utils.dart';
import '../../models/models.dart';
import '../../utils/utils.dart';
import '../widgets.dart';
import '../widgets/control_widgets/repeat_button_widget.dart';
import '../widgets/control_widgets/shuffle_button_widget.dart';
import '../widgets/custom_slider.dart';
import 'widgets.dart';
import 'widgets/set_timer_widget.dart';

class CurrentSongPlayerScreen extends StatelessWidget {
  const CurrentSongPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: const [
        _CurrentSongPlayerWidget(),
        LyricWidget(),
      ],
      options: CarouselOptions(
        height: double.infinity,
        enableInfiniteScroll: false,
        viewportFraction: 1,
      ),
    );
  }
}

class _CurrentSongPlayerWidget extends StatelessWidget {
  const _CurrentSongPlayerWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SongBloc, SongState>(
      builder: (context, state) {
        final currentSong = state.songInfo;
        final source = state.songSource;
        return FutureBuilder<PaletteGenerator>(
            future: updatePaletteGenerator(
              currentSong?.thumbnailM ?? "",
            ),
            builder: (context, snapshot) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      snapshot.hasData
                          ? snapshot.data!.dominantColor!.color
                          : Colors.black,
                      Colors.black,
                    ],
                    tileMode: TileMode.clamp,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const _CloseButtonWidget(),
                      CircleAvatar(
                        radius: 120,
                        backgroundImage: NetworkImage(
                          currentSong?.thumbnailM ?? "",
                        ),
                      ),
                      _SongInformationWidget(
                        song: convertSongInfo(currentSong!)!,
                      ),
                      // Music control field (Add to favorites, Add to playlists, ...)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          BlocConsumer<UserMusicBloc, UserMusicState>(
                            listenWhen: (prev, curr) =>
                                prev.status?[UserMusicStatusKey.song.name] !=
                                curr.status?[UserMusicStatusKey.song.name],
                            listener: (context, state) {
                              // Call dialog when user favorite the block music
                              if (state.error?.statusCode == 1000) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return PopupWarningWidget(
                                        description:
                                            'This song is in you block list. Do you want to remove it to favorite list?',
                                        onTap: () {
                                          context
                                              .read<UserMusicBloc>()
                                              .add(FavoriteSongEvent(
                                                id: currentSong.encodeId!,
                                                title: currentSong.title!,
                                                artistNames:
                                                    currentSong.artistsNames!,
                                                genreNames:
                                                    currentSong.genreNames,
                                                isRemoveDislike: true,
                                              ));
                                        },
                                      );
                                    });
                              }
                            },
                            builder: (context, state) {
                              List<String> songs =
                                  state.music?.favoriteSongs ?? [];
                              final bool isFavorite =
                                  songs.contains(currentSong.encodeId);
                              return IconButton(
                                onPressed: () {
                                  context
                                      .read<UserMusicBloc>()
                                      .add(CheckSongEvent(
                                        id: currentSong.encodeId!,
                                        title: currentSong.title!,
                                        artistNames: currentSong.artistsNames!,
                                        genreNames: currentSong.genreNames,
                                        isFavorite: true,
                                      ));
                                },
                                icon: Icon(
                                  isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_outline,
                                  color: Colors.white,
                                ),
                              );
                            },
                          ),
                          BlocConsumer<UserMusicBloc, UserMusicState>(
                            listenWhen: (prev, curr) =>
                                prev.status?[UserMusicStatusKey.song.name] !=
                                curr.status?[UserMusicStatusKey.song.name],
                            listener: (context, state) {
                              // Call dialog when user favorite the block music
                              if (state.error?.statusCode == 1001) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return PopupWarningWidget(
                                        description:
                                            'This song is in you favorite list. Do you want to remove it to block list?',
                                        onTap: () {
                                          context
                                              .read<UserMusicBloc>()
                                              .add(DislikeSongEvent(
                                                id: currentSong.encodeId!,
                                                title: currentSong.title!,
                                                artistNames:
                                                    currentSong.artistsNames!,
                                                genreNames:
                                                    currentSong.genreNames,
                                                isRemoveFavorite: true,
                                              ));
                                        },
                                      );
                                    });
                              }
                            },
                            builder: (context, state) {
                              List<String> songs =
                                  state.music?.dislikeSongs ?? [];
                              final bool isDislike =
                                  songs.contains(currentSong.encodeId);
                              return IconButton(
                                onPressed: () {
                                  context
                                      .read<UserMusicBloc>()
                                      .add(CheckSongEvent(
                                        id: currentSong.encodeId!,
                                        title: currentSong.title!,
                                        artistNames: currentSong.artistsNames!,
                                        genreNames: currentSong.genreNames,
                                        isFavorite: false,
                                      ));
                                },
                                icon: Icon(
                                  isDislike
                                      ? Icons.do_disturb_on
                                      : Icons.do_not_disturb_alt_outlined,
                                  color: Colors.white,
                                ),
                              );
                            },
                          ),
                          IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) =>
                                      SaveSongOwnPlaylistWidget(
                                        song: currentSong,
                                      ));
                            },
                            icon: const Icon(
                              Icons.playlist_add,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.transparent,
                                builder: (_) => SetTimerWidget(
                                  context: context,
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.nights_stay,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const CustomSlider(draggable: true),
                      // Audio player control field
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          ShuffleButtonWidget(),
                          SkipToPreviousButtonWidget(),
                          PlayButtonWidget(
                            width: 100,
                            height: 100,
                            iconSize: 50,
                          ),
                          SkipToNextButtonWidget(),
                          RepeatButtonWidget(),
                        ],
                      )
                    ],
                  ),
                ),
              );
            });
      },
    );
  }
}

class _CloseButtonWidget extends StatelessWidget {
  const _CloseButtonWidget();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.expand_more,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}

class _SongInformationWidget extends StatelessWidget {
  const _SongInformationWidget({
    required this.song,
  });

  final SongInfoModel song;

  @override
  Widget build(BuildContext context) {
    List<String> artists = song.artistsNames?.split(',') ?? [];
    bool isMultipleArtist = false;
    if (artists.length != song.alias?.length) {
      isMultipleArtist = true;
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          song.title ?? "",
          style: TextStyleTheme.ts28.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 10,
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
                          .add(ArtistGetInfoEvent(song.alias!.first));
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
                          context
                              .read<ArtistBloc>()
                              .add(ArtistGetInfoEvent(song.alias![index]));
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
          style: TextStyleTheme.ts20.copyWith(
            color: ColorTheme.primary,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
