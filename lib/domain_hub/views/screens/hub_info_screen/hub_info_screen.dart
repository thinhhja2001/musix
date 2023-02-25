import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/exporter.dart';
import '../../../../domain_artist/views/widgets.dart';
import '../../../../domain_music/views/widgets.dart';
import '../../../../domain_playlist/views/widgets.dart';
import '../../../../theme/theme.dart';
import '../../../../utils/utils.dart';

class HubInfoScreen extends StatelessWidget {
  const HubInfoScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorTheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            context.read<HubBloc>().add(const HubBackInfoEvent());
            Navigator.maybePop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_sharp,
            color: Colors.white,
            size: 20,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.add,
              color: Colors.white,
              size: 24,
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          vertical: 16,
        ),
        child: BlocBuilder<HubBloc, HubState>(
          builder: (context, state) {
            if (state.status?[HubStatusKey.info.key] == Status.loading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              final hub = state.info;
              if (hub == null) {
                return const SizedBox.shrink();
              } else {
                debugPrint('Hub: ${hub.title} - ${hub.description != null}');
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: size.width,
                      height: size.height * 0.32,
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
                            hub.cover!,
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
                          if (hub.description != null &&
                              hub.description != '') ...[
                            Text(
                              hub.title!,
                              style: TextStyleTheme.ts28.copyWith(
                                fontSize: 24,
                                fontWeight: FontWeight.w400,
                                color: Colors.white70,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              hub.description!,
                              style: TextStyleTheme.ts14.copyWith(
                                fontWeight: FontWeight.w400,
                                color: ColorTheme.primaryLighten,
                              ),
                            ),
                          ]
                        ],
                      ),
                    ),
                    ...List.generate(hub.playlists?.length ?? 0, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 24,
                        ),
                        child: PlaylistListWidget(
                          playlistArrange: PlaylistArrange.mason,
                          sectionPlaylist: hub.playlists![index],
                        ),
                      );
                    }),
                    if (hub.artists != null && hub.artists!.isNotEmpty) ...[
                      const SizedBox(
                        height: 12,
                      ),
                      ...List.generate(hub.artists?.length ?? 0, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 24,
                          ),
                          child: ArtistListWidget(
                            artistArrange: ArtistArrange.carousel,
                            sectionArtist: hub.artists![index],
                          ),
                        );
                      }),
                    ],
                    if (hub.songs != null && hub.songs!.isNotEmpty) ...[
                      const SizedBox(
                        height: 24,
                      ),
                      SongTabWidget(
                        items: hub.songs!,
                      ),
                    ],
                  ],
                );
              }
            }
          },
        ),
      ),
    );
  }
}
