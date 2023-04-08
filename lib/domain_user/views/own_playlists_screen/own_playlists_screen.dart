import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:musix/config/exporter.dart';
import 'package:musix/global/widgets/widgets.dart';
import 'package:musix/routing/routing_path.dart';

import '../../../domain_song/views/widgets.dart';
import '../../../theme/theme.dart';
import '../../../utils/utils.dart';
import 'widgets.dart';

class OwnPlaylistsScreen extends StatelessWidget {
  const OwnPlaylistsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        title: Text(
          'Own Playlists',
          style: TextStyleTheme.ts20.copyWith(
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => const AddNewOwnPlaylistWidget());
            },
            splashColor: Colors.white24,
            tooltip: 'Create New Playlist',
            icon: Icon(
              Icons.add,
              color: Colors.white.withOpacity(0.8),
              size: 24,
            ),
          ),
        ],
      ),
      body: BlocBuilder<UserMusicBloc, UserMusicState>(
        builder: (context, state) {
          if (state.status?[UserMusicStatusKey.global.name] == Status.loading) {
            return const Center(
                child: SpinKitPulse(
              color: ColorTheme.primary,
              size: 100,
            ));
          } else {
            var playlists = state.music?.ownPlaylists;
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
                          image: playlists[index].thumbnail ??
                              AssetPath.placeImage,
                          title: playlists[index].title!,
                          padding: 0,
                          onCardPress: () {
                            context
                                .read<OwnPlaylistBloc>()
                                .add(GetOwnPlaylistEvent(playlists[index]));
                            Navigator.pushNamed(
                              context,
                              RoutingPath.ownPlaylist,
                            );
                          },
                          isShowAdditionButton: false,
                          additionWidget: IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => RemoveOwnPlaylistWidget(
                                      playlistId: playlists[index].id!));
                            },
                            icon: const Icon(
                              Icons.do_disturb_on,
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
