import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../domain_song/views/widgets.dart';
import '../../../theme/theme.dart';

import '../../../config/exporter.dart';
import '../../../global/widgets/widgets.dart';
import '../../../routing/routing_path.dart';
import '../../../utils/utils.dart';

class PlaylistsInfoScreen extends StatelessWidget {
  const PlaylistsInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.background,
      persistentFooterButtons: [CurrentSongPlayerWidget()],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: BlocSelector<PlaylistsBloc, PlaylistsState, String>(
          selector: (state) => state.title ?? "",
          builder: (context, title) {
            return Text(title);
          },
        ),
        titleTextStyle: TextStyleTheme.ts22
            .copyWith(color: Colors.white, fontWeight: FontWeight.w300),
        leading: IconButton(
          onPressed: () {
            context.read<PlaylistsBloc>().add(const BackPlaylistsEvent());
            Navigator.maybePop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_sharp,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
      body: BlocBuilder<PlaylistsBloc, PlaylistsState>(
        builder: (context, state) {
          if (state.status?[PlaylistsStatusKey.global.name] == Status.loading) {
            return const Center(
                child: SpinKitPulse(
              color: ColorTheme.primary,
              size: 100,
            ));
          } else {
            var playlists = state.playlists;
            if (playlists == null || playlists.isEmpty == true) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.sentiment_dissatisfied_outlined,
                      size: 24,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      r"There's no playlists here",
                      style: TextStyleTheme.ts15.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              );
            }
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...List.generate(
                    playlists.length,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: CustomCardInfoWidget(
                          index: index,
                          image: playlists[index].thumbnailM,
                          title: playlists[index].title!,
                          subTitle: playlists[index].artistsNames,
                          padding: 0,
                          onCardPress: () {
                            context.read<PlaylistBloc>().add(
                                PlaylistGetInfoEvent(
                                    playlists[index].encodeId!));
                            Navigator.pushNamed(
                              context,
                              RoutingPath.playlistInfo,
                            );
                          },
                          isShowAdditionButton: false,
                          additionWidget: IconButton(
                            onPressed: () {
                              context.read<PlaylistsBloc>().add(
                                  RemovePlaylistEvent(
                                      playlists[index].encodeId!));
                              context
                                  .read<UserMusicBloc>()
                                  .add(FavoritePlaylistEvent(
                                    id: playlists[index].encodeId!,
                                    title: playlists[index].title!,
                                    artistNames: playlists[index].artistsNames!,
                                    genreNames: playlists[index].genres,
                                  ));
                            },
                            icon: Icon(
                              state.title!.contains("Favorite")
                                  ? Icons.favorite
                                  : Icons.do_disturb_on,
                              color: Colors.redAccent,
                              size: 24,
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
