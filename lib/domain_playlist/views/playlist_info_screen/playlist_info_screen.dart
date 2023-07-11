import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';

import '../../../config/exporter/bloc_exporter.dart';
import '../../../config/exporter/state_exporter.dart';
import '../../../domain_song/views/widgets.dart';
import '../../../domain_song/views/widgets/control_widgets/shuffle_button_widget.dart';
import '../../../theme/theme.dart';
import '../../../utils/utils.dart';
import '../../entities/entities.dart';

class PlaylistInfoScreen extends StatelessWidget {
  const PlaylistInfoScreen({
    Key? key,
  }) : super(key: key);

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
            context.read<PlaylistBloc>().add(const PlaylistBackInfoEvent());
            Navigator.maybePop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_sharp,
            color: Colors.white,
            size: 20,
          ),
        ),
        actions: [
          BlocSelector<PlaylistBloc, PlaylistState, Playlist?>(
            selector: (state) {
              return state.playlist;
            },
            builder: (context, playlist) {
              if (playlist != null) {
                return BlocSelector<UserMusicBloc, UserMusicState, bool>(
                  selector: (userMusicState) {
                    List<String> playlists =
                        userMusicState.music?.favoritePlaylists ?? [];
                    return playlists.contains(playlist.encodeId);
                  },
                  builder: (context, isFavorite) {
                    return IconButton(
                      onPressed: () {
                        context.read<UserMusicBloc>().add(FavoritePlaylistEvent(
                              id: playlist.encodeId!,
                              title: playlist.title!,
                              artistNames: playlist.artistsNames!,
                              genreNames: playlist.genres
                                  ?.map((e) => e.title!)
                                  .toList(),
                            ));
                      },
                      splashColor: Colors.red.withOpacity(0.2),
                      tooltip: 'Favorite',
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_outline,
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
                    Icons.favorite_outline,
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
      body: BlocBuilder<PlaylistBloc, PlaylistState>(
        builder: (context, state) {
          if (state.status?[PlaylistStatusKey.info.key] == Status.loading) {
            return const Center(
                child: SpinKitPulse(
              color: ColorTheme.primary,
              size: 100,
            ));
          } else {
            final playlist = state.playlist;

            if (playlist == null) {
              return const SizedBox.shrink();
            } else {
              return Stack(
                children: [
                  Opacity(
                    opacity: 0.4,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(24),
                          bottomRight: Radius.circular(24),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red.shade900,
                            offset: const Offset(
                              2,
                              4,
                            ),
                            blurRadius: 10.0,
                            spreadRadius: 1.0,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(24),
                          bottomRight: Radius.circular(24),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: playlist.thumbnailM!,
                          progressIndicatorBuilder: (context, _, __) {
                            return const Center(
                                child: CircularProgressIndicator());
                          },
                          width: size.width,
                          height: size.height * 0.4,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Center(
                      child: Container(
                        width: double.maxFinite,
                        height: size.height * 0.8,
                        decoration: BoxDecoration(
                          color: const Color(0xff383676),
                          borderRadius: BorderRadius.circular(36),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.2),
                              blurRadius: 30,
                            ),
                          ],
                        ),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 24,
                        ),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          playlist.title!,
                                          style: TextStyleTheme.ts20.copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          playlist.artistsNames!,
                                          style: TextStyleTheme.ts14.copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const ShuffleButtonWidget(),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      context.read<SongBloc>().add(
                                          SongSetListSongInfoEvent(
                                              state.playlist?.songs?.items));

                                      ///Passing nul will start playing the song base on current state of
                                      ///@isShuffle in SongBloc
                                      ///If @isShuffle is true, generate a random index and start playing at the index.
                                      ///If @isShuffle is false, start playing the section at the index of 0
                                      context.read<SongBloc>().add(
                                            SongStartPlayingSectionEvent(null),
                                          );
                                    },
                                    icon: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(180),
                                        border: Border.all(
                                          color: Colors.white,
                                        ),
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.play_arrow_rounded,
                                          size: 24,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Text(
                                playlist.description!,
                                style: TextStyleTheme.ts14.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xffE8BCD3),
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(24),
                                child: CachedNetworkImage(
                                  imageUrl: playlist.thumbnail!,
                                  placeholder: (context, url) =>
                                      Shimmer.fromColors(
                                    baseColor: ColorTheme.background,
                                    highlightColor: ColorTheme.backgroundDarker,
                                    child: Material(
                                      color: Colors.white,
                                      child: SizedBox(
                                        width: size.width,
                                        height: 240,
                                      ),
                                    ),
                                  ),
                                  width: size.width,
                                  height: 240,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              SongListWidget(
                                sectionSong: playlist.songs!,
                                isScrollable: false,
                                isShowIndex: true,
                                songArrange: SongArrange.info,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          }
        },
      ),
    );
  }
}
