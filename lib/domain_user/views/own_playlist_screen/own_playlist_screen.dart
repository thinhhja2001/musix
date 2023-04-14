import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../config/exporter.dart';
import '../../../domain_hub/entities/entities.dart';
import '../../../domain_song/views/widgets.dart';
import '../../../domain_song/views/widgets/control_widgets/shuffle_button_widget.dart';
import 'widgets/own_playlist_thumbnail_widget.dart';
import '../own_playlists_screen/widgets.dart';
import '../../../theme/theme.dart';
import '../../../utils/utils.dart';

import 'widgets/edit_own_playlist_widget.dart';

class OwnPlaylistScreen extends StatelessWidget {
  const OwnPlaylistScreen({Key? key}) : super(key: key);

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
            Navigator.maybePop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_sharp,
            color: Colors.white,
            size: 20,
          ),
        ),
        actions: [
          BlocBuilder<OwnPlaylistBloc, OwnPlaylistState>(
            builder: (context, state) {
              if (state.id != null) {
                return IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => EditOwnPlaylistWidget(
                              id: state.id!,
                              title: state.title!,
                              description: state.description,
                            ));
                  },
                  splashColor: Colors.white54,
                  tooltip: 'Edit',
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 24,
                  ),
                );
              } else {
                return const Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 24,
                );
              }
            },
          ),
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => RemoveOwnPlaylistWidget(
                        playlistId:
                            BlocProvider.of<OwnPlaylistBloc>(context).state.id!,
                      )).then((value) => Navigator.of(context).maybePop());
            },
            splashColor: Colors.red.withOpacity(0.2),
            tooltip: 'Remove Playlist',
            icon: Icon(
              Icons.do_disturb_on,
              color: Colors.red.withOpacity(0.8),
              size: 24,
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: BlocBuilder<OwnPlaylistBloc, OwnPlaylistState>(
        buildWhen: (oldState, curState) =>
            oldState.status?[OwnPlaylistStatusKey.global.name] != Status.error,
        builder: (context, state) {
          if (state.status?[OwnPlaylistStatusKey.global.name] ==
              Status.loading) {
            return const Center(
                child: SpinKitPulse(
              color: ColorTheme.primary,
              size: 100,
            ));
          }
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
                      imageUrl: state.thumbnail ?? AssetPath.placeImage,
                      progressIndicatorBuilder: (context, _, __) {
                        return const Center(child: CircularProgressIndicator());
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
                                child: Text(
                                  state.title!,
                                  style: TextStyleTheme.ts20.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const ShuffleButtonWidget(),
                              const SizedBox(
                                width: 8,
                              ),
                              IconButton(
                                onPressed: state.songs == null ||
                                        state.songs?.isEmpty == true
                                    ? null
                                    : () {
                                        context.read<SongBloc>().add(
                                            SongSetListSongInfoEvent(
                                                state.songs));

                                        ///Passing nul will start playing the song base on current state of
                                        ///@isShuffle in SongBloc
                                        ///If @isShuffle is true, generate a random index and start playing at the index.
                                        ///If @isShuffle is false, start playing the section at the index of 0
                                        context.read<SongBloc>().add(
                                              SongStartPlayingSectionEvent(
                                                  null),
                                            );
                                      },
                                icon: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(180),
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
                            state.description ?? "",
                            style: TextStyleTheme.ts16.copyWith(
                              fontWeight: FontWeight.w400,
                              color: const Color(0xffE8BCD3),
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          OwnPlaylistThumbnailWidget(playlistId: state.id!),
                          const SizedBox(
                            height: 12,
                          ),
                          if (state.songs == null || state.songs!.isEmpty) ...[
                            Text(
                              'There is no songs in list',
                              style: TextStyleTheme.ts16.copyWith(
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ] else
                            SongListWidget(
                              sectionSong: SectionSong(items: state.songs),
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
        },
      ),
    );
  }
}
