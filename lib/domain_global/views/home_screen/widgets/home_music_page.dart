import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../config/exporter.dart';
import '../../../../domain_hub/entities/section/section_song.dart';
import '../../../../domain_hub/views/widgets.dart';
import '../../../../domain_playlist/views/widgets.dart';
import '../../../../domain_song/views/widgets.dart';
import '../../../../routing/routing_path.dart';
import '../../../../utils/utils.dart';
import '../../../entities/entities.dart';
import '../widgets.dart';

class HomeMusicPage extends StatefulWidget {
  const HomeMusicPage({Key? key}) : super(key: key);

  @override
  State<HomeMusicPage> createState() => _HomeMusicPageState();
}

class _HomeMusicPageState extends State<HomeMusicPage> {
  @override
  void initState() {
    super.initState();
    context.read<HomeMusicBloc>().add(const HomeMusicGetEvent());
  }

  @override
  Widget build(BuildContext context) {
    return HomeTemplateWidget(
      body: BlocBuilder<HomeMusicBloc, HomeMusicState>(
        builder: (context, state) {
          if (state.status?[HomeMusicStatusKey.global.key] == Status.loading) {
            return const Center(
                child: SpinKitWanderingCubes(
              color: Colors.white54,
            ));
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
                    SearchBarNavigationWidget(
                      hintText: r'What do you want to hear?',
                      onTap: () {
                        Navigator.of(context).pushNamed(RoutingPath.searchSong);
                      },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    BlocBuilder<UserRecordBloc, UserRecordState>(
                      builder: (context, state) {
                        if (state.status?[UserRecordStatusKey.recommend.name] ==
                            Status.loading) {
                          return const Center(
                              child: SpinKitWanderingCubes(
                            color: Colors.white54,
                          ));
                        }
                        if (state.status?[UserRecordStatusKey.recommend.name] ==
                            Status.error) {
                          return const SizedBox.shrink();
                        }
                        var recommends = state.record?.recommendSongs;
                        if (recommends == null || recommends.isEmpty) {
                          return const SizedBox.shrink();
                        }

                        return SongListWidget(
                          sectionSong: SectionSong(
                            items: recommends,
                            title: 'Gợi ý',
                            total: recommends.length,
                          ),
                          songArrange: SongArrange.carousel,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    HubListWidget(
                      title: 'Topics',
                      hubs: homeMusic.hubs!,
                    ),
                    ...List.generate(
                      homeMusic.sectionPlaylists!.length,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: PlaylistListWidget(
                          sectionPlaylist: homeMusic.sectionPlaylists![index],
                          playlistArrange: PlaylistArrange.carousel,
                        ),
                      ),
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
