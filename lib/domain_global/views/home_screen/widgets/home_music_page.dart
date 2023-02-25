import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/config/exporter.dart';
import 'package:musix/domain_playlist/views/widgets.dart';

import '../../../../domain_artist/views/widgets.dart';
import '../../../../domain_music/views/widgets.dart';
import '../../../../utils/utils.dart';
import '../../../entities/entities.dart';
import 'widgets.dart';

class BillboardPageWidget extends StatelessWidget {
  const BillboardPageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeTemplateWidget(
      body: BlocBuilder<HomeMusicBloc, HomeMusicState>(
        builder: (context, state) {
          if (state.status?[HomeMusicStatusKey.global.key] == Status.loading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            final HomeMusic? homeMusic = state.homeMusic;
            if (homeMusic == null) {
              return const SizedBox.shrink();
            } else {
              debugPrint('HomeMusic != null');
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    PlaylistListWidget(
                      sectionPlaylist: homeMusic.newPlaylists!,
                      playlistArrange: PlaylistArrange.carousel,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    ArtistListWidget(
                      sectionArtist: homeMusic.representArtists!,
                      artistArrange: ArtistArrange.carousel,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    PlaylistListWidget(
                      sectionPlaylist: homeMusic.randomPlaylist!,
                      playlistArrange: PlaylistArrange.carousel,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    SongTabWidget(
                      items: homeMusic.newReleaseSongs!.reversed.toList(),
                    ),
                  ],
                ),
              );
            }
          }
        },
      ),
    );
  }
}
